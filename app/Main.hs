import Html
main :: IO ()
main = do 
    putStrLn (render myPage)

myPage :: Html
myPage =
    let
        title = "my page"
        content = 
            h1_ "Hello" <>
                p_ "Welcome to"<>
                p_ "my page" <>
                p_ "<html></html>"
    in html_ title content

