module Convert where

import qualified Markup
import qualified Html 

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
     
    -- fixme either[E, A] 
    _ -> Html.p_ ""
 
  
