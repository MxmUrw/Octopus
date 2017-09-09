
module A_Infrastructure
  (
      run
  )
  where

---  Imports  ---
import Dhall



---  Data  ---
data StorageLocation = StorageLocation
  {
      path :: Text,
      encryption_key :: Maybe Text
  }
  deriving (Generic, Show)
instance Interpret StorageLocation


data Item = Item
  {
      path :: Text,
      targets :: Vector StorageLocation
  }
  deriving (Generic, Show)
instance Interpret Item


data Config = Config
  {
      roots :: Vector Text,
      items :: Vector Item
  }
  deriving (Generic, Show)
instance Interpret Config



run :: IO ()
run =
  do
      x <- input auto "./config"
      print (x :: Config)
      putStrLn "Done"


