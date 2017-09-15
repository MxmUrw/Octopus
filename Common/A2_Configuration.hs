
module A2_Configuration
  (
      readLocal,
      Config(..),
      Item(..),
      StorageLocation(..),
      Vector(..),
      pathOfItem,
      pathOfStorageLocation
  )
  where

--- Imports ---
import Data.Text.Lazy as T
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

pathOfItem :: Item -> FilePath
pathOfItem = T.unpack . (path :: Item -> Text)

pathOfStorageLocation :: StorageLocation -> FilePath
pathOfStorageLocation = T.unpack . (path :: StorageLocation -> Text)


--- Functions ---
readLocal :: IO Config
readLocal = input auto "./config"
