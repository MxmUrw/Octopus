
module B_Status
  (
      lastChange,
      showTime
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
lastChange = utcToLocalZonedTime <=< lastChange'

lastChange' :: FilePath -> IO UTCTime
lastChange' p =
    join $ fold always update (getModificationTime p) p
  where
    update :: IO UTCTime -> FileInfo -> IO UTCTime
    update t i =
      do
          t1 <- t
          t2 <- getModificationTime (infoPath i)
          return (max t1 t2)








showTime :: ZonedTime -> String
showTime = formatTime defaultTimeLocale "%T"
