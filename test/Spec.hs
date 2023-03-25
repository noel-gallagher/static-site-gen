import Test.QuickCheck
import Test.Hspec
import Html

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
    header = h1_ title 
    expected = "<h1>" <> title <> "</h1>" 
  in
    getStructureString header == expected 

main :: IO ()
main = hspec $ do 
  describe "html gen" $ do
    it "should wrap paragraphs" $ do
     property $ \str -> prop_p str `shouldBe` True
    it "should wrap h1" $ do
      property $ \str -> prop_h1 str `shouldBe` True
