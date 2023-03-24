import Test.QuickCheck
import Html

prop_p :: String -> Bool
prop_p content =
  let
    paragraph = p_ content
    expected = "<p>" <> content <> "</p>"
  in
     show paragraph == expected

prop_h1 :: Title -> Bool
prop_h1 title = 
  let
    header = h1_ title 
    expected = "<h1>" <> title <> "</h1>" 
  in
    show header == expected


main :: IO ()
main = quickCheck prop_p
