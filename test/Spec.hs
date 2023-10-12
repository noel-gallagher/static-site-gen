import Test.QuickCheck
import Test.Hspec
import Html

specialCharsToExclude :: [Char]
specialCharsToExclude = "<>&\"\'"

stringWithoutConverted :: Gen String
stringWithoutConverted = listOf $ elements $ filter (`notElem` specialCharsToExclude) [' ' .. '-']

prop_p :: String -> Bool
prop_p content =
  let
    paragraph = p_ content
    expected = "<p>" <> content <> "</p>"
  in
     getStructureString paragraph == expected

prop_h1 :: Title -> Bool
prop_h1 title = 
  let
    header = h_ 1 title 
    expected = "<h1>" <> title <> "</h1>" 
  in
    getStructureString header == expected 

testEscapeChar :: (String, String) -> SpecWith ()
testEscapeChar (input, expected) =
  it ("correctly escapes the character " ++ input) $ 
   escape input `shouldBe` expected 

main :: IO ()
main = hspec $ do 
  describe "html gen" $ do
    it "should wrap paragraphs" $ do
      property $ forAll stringWithoutConverted $ \str -> prop_p str `shouldBe` True

    it "should wrap h1" $ do
      property $ forAll stringWithoutConverted $ \str -> prop_h1 str `shouldBe` True
    
    let escapeChars = [("<", "&lt"),
                        (">", "&gt"),
                        ("\"", "&quot"),
                        ("\'", "&#39"),
                        ("&", "&amp")]
    mapM_ testEscapeChar escapeChars 


