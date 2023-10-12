module Convert where

import qualified Markup
import qualified Html.Internal as HI

convertStructure :: Markup.Structure -> Html.Structure
convertStructure structure =
  Markup.Heading n txt ->
    Html.h n txt
  
  Markup.Paragraph p ->
    Html.p_ p
  
  Markup.UnorderedList struct ->
    Html.ul_ convertStructure struct 

  Markup.OrderedList struct ->
    Html.ol_ struct

  Markup.Codeblock code ->
    Html.codeBlock_ code
 
  
