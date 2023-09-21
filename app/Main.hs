{-# LANGUAGE OverloadedStrings #-}

module Main where

import Data.IORef
import Web.Spock
import Web.Spock.Config
import Web.Spock.Lucid (lucid)
import Lucid
import Data.Text (Text, unpack) 
import Control.Monad.IO.Class (liftIO)
import Control.Monad (forM_)

data Developer = Developer
    { developerName :: Text
    , developerSkills :: Text
    , developerExperience :: Integer 
    , developerSpecialization :: Text
    }

data Project = Project
    { projectName :: Text
    , projectDescription :: Text
    , projectDeadline :: Integer
    , projectComplexity :: Integer
    , projectDifficulty :: Text 
    , projectTechnologies :: Text
    , projectRequirements :: Text
    }

data Match = Match
    { developer :: Text
    , contents :: Text
    , hourlyRate :: Float 
    }

data ServerState = ServerState
    { matches :: IORef [Match]
    , developers :: IORef [Developer]
    }

type Server a = SpockM () () ServerState a

app :: Server ()
app = do
    get root $ do
        matches' <- getState >>= (liftIO . readIORef . matches)
        lucid $ do
            h1_ "Price Matcher"
            p_ "Calcule o valor a ser cobrado por suas horas de trabalho com base na complexidade e dificuldade de um projeto."
            ul_ $ forM_ matches' $ \note -> li_ $ do
                toHtml (developer note)
                ":"
                toHtml (contents note)
                " - Hourly Rate: R$"
                toHtml (show $ hourlyRate note)
            h2_ "Novo Match"
            form_ [method_ "post"] $ do
                label_ $ do
                    "Desenvolvedor: "
                    input_ [name_ "developerName"]
                label_ $ do
                    "Experiência em anos: "
                    input_ [name_ "developerExperience", type_ "number", min_ "0"] 
                label_ $ do
                    "Especialização: "
                    select_ [name_ "developerSpecialization"] $ do
                        option_ [value_ "Backend"] "Backend"
                        option_ [value_ "Frontend"] "Frontend"
                        option_ [value_ "FullStack"] "Full-Stack"
                label_ $ do
                    "Projeto: "
                    input_ [name_ "projectName"]
                label_ $ do
                    "Complexidade do Projeto: "
                    input_ [name_ "projectComplexity", type_ "number", min_ "1", max_ "5"]
                label_ $ do
                    "Dificuldade do Projeto: "
                    select_ [name_ "projectDifficulty"] $ do
                        option_ [value_ "1"] "Iniciante"
                        option_ [value_ "2"] "Intermediário"
                        option_ [value_ "3"] "Avançado"

                input_ [type_ "submit", value_ "Calcular"]

    post root $ do
        developerName <- param' "developerName"
        projectName <- param' "projectName"
        complexity <- param' "projectComplexity"
        difficulty <- param' "projectDifficulty"
        experience <- param' "developerExperience"
        
        let hourlyRate = calculateHourlyRate complexity (read (unpack difficulty) :: Integer) (read (unpack experience) :: Integer) 
        matchesRef <- matches <$> getState
        liftIO $ atomicModifyIORef' matchesRef $ \matches ->
            (matches <> [Match developerName projectName hourlyRate], ())
        redirect "/"

    get "developer/profile" $ do
        lucid $ do
            h1_ "Perfil do Desenvolvedor"
            form_ [method_ "post", action_ "/developer/profile"] $ do
                label_ $ do
                    "Nome: "
                    input_ [name_ "name"]
                label_ $ do
                    "Habilidades: "
                    textarea_ [name_ "skills"] ""
                label_ $ do
                    "Experiência em anos: "
                    input_ [name_ "developerExperience", type_ "number", min_ "0"]
                label_ $ do
                    "Especialização: "
                    select_ [name_ "developerSpecialization"] $ do
                        option_ [value_ "Backend"] "Backend"
                        option_ [value_ "Frontend"] "Frontend"
                        option_ [value_ "FullStack"] "Full-Stack"
                input_ [type_ "submit", value_ "Salvar"]

    post "developer/profile" $ do
        name <- param' "name"
        skills <- param' "skills"
        experience <- param' "developerExperience"
        specialization <- param' "developerSpecialization"
        
        let newDeveloper = Developer name skills (read (unpack experience) :: Integer) specialization 
        serverState <- getState
        liftIO $ modifyIORef' (developers serverState) (newDeveloper :)
        redirect "/"

calculateHourlyRate :: Integer -> Integer -> Integer -> Float
calculateHourlyRate complexity difficulty experience =
    fromIntegral (complexity * 10 + difficulty * 5 + experience * 2) 

main :: IO ()
main = do
    matchesRef <- newIORef []
    developersRef <- newIORef []
    let serverState = ServerState matchesRef developersRef
    cfg <- defaultSpockCfg () PCNoDatabase serverState
    runSpock 8080 (spock cfg app)
