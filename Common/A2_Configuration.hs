
module A2_Configuration
  (
      readLocal,
      Config(..),
      Item(..),
      StorageLocation(..),
      Vector(..)
  )
  where

--- Imports ---
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


--- Functions ---
readLocal :: IO Config
readLocal = input auto "./config"
