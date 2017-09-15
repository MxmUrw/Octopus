
module B_Status
  (
      getStatus,
      showStatus,
      Item(..)
  )
  where

--- Imports ---
import Crypto.Hash
import System.FilePath.Find
import System.IO
import System.Directory
import Data.Time.Clock
import Data.Time.Format
import Data.Time.LocalTime
import Data.Text.Lazy
import Control.Monad

--- Data ---

--- Functions ---

data Action = Upload | Download
  deriving (Show)

data Status i j = Status
  {
      source :: i,
      target :: j,
      sourceTime :: UTCTime,
      targetTime :: UTCTime,
      action :: Action
  }

class Item i where
    getPath :: i -> FilePath
    getShortName :: i -> String



getStatus :: (Item a, Item b) => a -> b -> IO (Status a b)
getStatus a b =
  do
      t1 <- lastChange a
      t2 <- lastChange b
      return $ Status a b t1 t2 (if t1 > t2 then Upload else Download)




lastChange :: (Item a) => a -> IO UTCTime
lastChange a =
    join $ fold always update (getModificationTime $ getPath a) (getPath a)
  where
    update :: IO UTCTime -> FileInfo -> IO UTCTime
    update t i =
      do
          t1 <- t
          t2 <- getModificationTime (infoPath i)
          return (max t1 t2)








showTime :: UTCTime -> IO String
showTime = fmap (formatTime defaultTimeLocale "%T") . utcToLocalZonedTime


showStatus :: (Item a, Item b) => Status a b -> IO String
showStatus (Status a b t1 t2 x) =
  do
      tt1 <- showTime t1
      tt2 <- showTime t2
      return $
        getShortName a
        ++ " (" ++ tt1 ++ ")"
        ++ " -> "
        ++ getShortName b
        ++ " (" ++ tt2 ++ ")"
        ++ " [" ++ show x ++ "]"

