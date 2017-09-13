
module A_Infrastructure
  (
      run
  )
  where

--- Imports ---
import qualified A1_CLI as CLI
import qualified A2_Configuration as Configuration



run :: IO ()
run =
  do
      putStrLn "--- Args ---"
      (putStrLn . show) =<< CLI.parseCommands
      putStrLn "--- Config ---"
      x <- Configuration.readLocal
      print x
      putStrLn "Done"


