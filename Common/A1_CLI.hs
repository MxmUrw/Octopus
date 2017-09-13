
module A1_CLI
  (
      parseCommands, Command(..)
  )
  where

---  Imports  ---
import Options.Applicative
import Data.Semigroup ((<>))

--- Data ---
data Command = Status | Sync
  deriving (Show)

---------------------------------------------
--- Public Interface ---

parseCommands :: IO Command
parseCommands = execParser commandsInfo


--- Private Parsers ---
commandsInfo :: ParserInfo Command
commandsInfo = info (commands <**> helper)
  (fullDesc
  <> header "Octopus - file sync utility")

commands :: Parser Command
commands = subparser
  (
      command "status" (info statusOptions
                        (progDesc "View status of watched directories"))
  <>
      command "sync" (info syncOptions
                      (progDesc "Sync directories"))
  )



statusOptions :: Parser Command
statusOptions = pure Status

syncOptions :: Parser Command
syncOptions = pure Sync

