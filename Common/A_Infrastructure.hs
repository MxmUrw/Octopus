
module A_Infrastructure
  (
      run
  )
  where

--- Imports ---
import Data.Text.Lazy
import Control.Monad

import qualified A1_CLI as CLI
import qualified A2_Configuration as CONF
import qualified B_Status as STAT



run :: IO ()
run =
  do
      conf <- CONF.readLocal

      cmd <- CLI.parseCommands
      case cmd of
        CLI.Status -> status conf
        CLI.Sync -> putStrLn "sync"

      putStrLn "Done"



data ItemBinding = ItemBinding
  {
      getPathOfItemBinding :: FilePath
  }
instance STAT.Item ItemBinding where
    getPath = getPathOfItemBinding
    getShortName = getPathOfItemBinding


status :: CONF.Config -> IO ()
status conf =
  do
      putStrLn "--- Status ---"
      mapM_ printItem (CONF.items conf)
  where

      printItem :: CONF.Item -> IO ()
      printItem a =
        do
            mapM_ (putStrLn <=< STAT.showStatus <=< STAT.getStatus (ItemBinding $ CONF.pathOfItem a))
                  (ItemBinding <$> CONF.pathOfStorageLocation <$> CONF.targets a)
            putStrLn "\n"




