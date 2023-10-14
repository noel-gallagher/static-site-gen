module Convert where

import qualified Markup
import qualified Html 


convert :: Html.Title -> Markup.Document -> Html.Html
convert title = Html.html_ title . foldMap convertStructure

convertStructure :: Markup.Structure -> Html.Structure
convertStructure structure =
  case structure of
    Markup.Heading n txt ->
      Html.h_ n txt
  
    Markup.Paragraph p ->
      Html.p_ p
    
    Markup.UnorderedList li ->
      Html.ol_ $ map Html.p_ li  
    
    Markup.OrderedList li ->
      Html.ol_ $ map Html.p_ li
    
    Markup.Codeblock cb ->
      Html.codeBlock_ (unlines cb)
  
