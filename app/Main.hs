import Html
main :: IO ()
main = do 
    putStrLn (render myPage)

myPage :: Html
myPage =
    let
        title = "my page"
        content = append_
            (h1_ "Hello")
            (append_
                (p_ "Welcome to")
                (p_ "my page")
            )
    in html_ title content

