salt = require 'salt'

registros, err = salt.load('./registro.ltr')

io.write('Digite nome ou sobrenome:\t')
busca_arg = io.read()
for index,file_title in ipairs(registros) do
        if string.find(file_title:lower(), busca_arg:lower()) then
                registro, err = salt.load('./'..file_title)
                if not err then
                        for campo, valor in pairs(registro) do
                                print(campo..':\t'..valor)
                        end
                        print('=-=-=-=-=-=-=-=-=-=-=-=-=-=-=')
                else
                        print('Problema na base de dados, registro não encontrado!')
                end
        end
end