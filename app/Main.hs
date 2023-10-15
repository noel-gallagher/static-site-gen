import Html
import Markup
import Convert (convert)

import System.Directory (doesFileExist)
import System.Environment (getArgs)

process :: Title -> String -> String
process title = Html.render . convert title . Markup.parse

main :: IO ()
main = do 
    args <- getArgs
    case args of

        [] -> do
            content <- getContents
            putStrLn (process "Empty title" content)

        [input, output] -> do
            content <- readFile input -- inputfile will be the title 
            writeFile output (process input content)

        _ -> putStrLn "Invalid. usage: input output"

