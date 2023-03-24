module Html
( Html
, Title
, Structure
, html_
, p_
, h1_
, append_
, render
) where

newtype Html = Html String

newtype Structure = Structure String deriving Show

type Title = String

html_ :: Title -> Structure -> Html
html_ title content = 
  Html $ 
    el "html" $
      el "head" (el "title" title)
       <> el "body" (getStructureString content)

getStructureString :: Structure -> String
getStructureString (Structure str) = str  

el :: String -> String -> String
el tag content = "<" <> tag <> ">" <> content <> "</" <> tag <> ">"

p_ :: String -> Structure
p_ = Structure . el "p"

h1_ :: String -> Structure
h1_ = Structure . el "h1"

append_ :: Structure -> Structure -> Structure
append_ (Structure first) (Structure second) = Structure (first <> second)

render :: Html -> String
render (Html content) = content 
