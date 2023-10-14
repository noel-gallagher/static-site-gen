module Html
( Html
, Title
, Structure
, html_
, p_
, ul_
, ol_
, codeBlock_
, h_
, render
, getStructureString
, escape
) where
import Text.Read (Lexeme(String))
import Numeric.Natural

newtype Html = Html String

newtype Structure = Structure String
instance Semigroup Structure where
  (<>) c1 c2 = 
    Structure (getStructureString c1 <> getStructureString c2)

instance Monoid Structure where
  mempty = Structure ""

type Title = String

html_ :: Title -> Structure -> Html
html_ title content = 
  Html $ 
    el "html" $
      el "head" (el "title" (escape title))
       <> el "body" (getStructureString content)

getStructureString :: Structure -> String
getStructureString (Structure str) = str  

el :: String -> String -> String
el tag content = "<" <> tag <> ">" <> content <> "</" <> tag <> ">"

p_ :: String -> Structure
p_ = Structure . el "p" . escape

h_ :: Natural -> String -> Structure
h_ n = Structure . el ("h" <> show n) . escape

ul_ :: [Structure] -> Structure 
ul_ = Structure . 
        el "ul" . 
          concatMap (el "li" . getStructureString) 

ol_ :: [Structure] -> Structure
ol_ = Structure . el "ol" . concatMap (el "li" . getStructureString)

codeBlock_ :: String -> Structure
codeBlock_ = Structure . el "pre" . escape

escape :: String -> String
escape = 
  let
    escapeChar c = 
      case c of
        '<' -> "&lt"
        '>' -> "&gt"
        '&' -> "&amp"
        '"' -> "&quot"
        '\'' -> "&#39"
        _ -> [c]
  in
    concatMap escapeChar

render :: Html -> String
render (Html content) = content 
