module Html
( Html
, Title
, Structure
, html_
, p_
, h1_
, append_
, render
, getStructureString
) where
import Text.Read (Lexeme(String))

newtype Html = Html String

newtype Structure = Structure String

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

h1_ :: String ->Structure
h1_ = Structure . el "h1" . escape

ul_ :: [Structure] -> Structure 
ul_ = Structure . 
        el "ul" . 
          concatMap (el "li" . getStructureString) 

ol_ :: [Structure] -> Structure
ol_ = Structure . el "ol" . concatMap (el "li" . getStructureString)

codeBlock_ :: String -> Structure
codeBlock_ = Structure . el "pre" . escape

append_ :: Structure -> Structure -> Structure
append_ (Structure first) (Structure second) = Structure (first <> second)

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
    concat . map escapeChar

render :: Html -> String
render (Html content) = content 
