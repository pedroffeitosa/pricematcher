module Experiencia where
    import Data

    data Experiencia = Experiencia {
        id :: Int,
        descricao :: String,
        dataInicio :: Data,
        dataFim :: Data,
        multiplicador :: Float
    }

    getDescricao :: Experiencia -> String
    getDescricao = descricao

    getDataInicio :: Experiencia -> Data
    getDataInicio = dataInicio
    
    getDataFim :: Experiencia -> Data
    getDataFim = dataFim

    getAnosTrabalho :: Experiencia -> Int
    getAnosTrabalho exp = getAno (getDataFim exp) - getAno (getDataInicio exp)

    getMultiplicador :: Experiencia -> Float
    getMultiplicador = multiplicador
    