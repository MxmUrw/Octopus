
module A_Infrastructure
  (
      run
  )
  where

--- Imports ---
import Data.Text.Lazy
import Control.Monad

import qualified A1_CLI as CLI
import qualified A2_Configuration as A2
import qualified B_Status as B



run :: IO ()
run =
  do
      conf <- A2.readLocal

      cmd <- CLI.parseCommands
      case cmd of
        CLI.Status -> status conf
        CLI.Sync -> putStrLn "sync"

      putStrLn "Done"



status :: A2.Config -> IO ()
status conf =
  do
      putStrLn "--- Status ---"
      mapM_ (putStrLn <=< fmap B.showTime . B.lastChange) (getItems conf)
  where
      getItems :: A2.Config -> A2.Vector String
      getItems = fmap unpack . fmap (A2.path :: A2.Item -> Text) . A2.items




