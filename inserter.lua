salt = require 'salt'
s = require 'schema'

registro, err = salt.load('./registro.ltr')
if err then
        registro = {}
end

userSchema = s.Record{
        name = s.String,
        surname = s.String,
        username = s.Pattern('[A-Za-z][A-Za-z_]*'),
        password = s.Pattern('......'),
        permissoes = s.OneOf('root', 'user', 'guest')
}

repeat
        user = {}
        io.write('Digite seu nome:\t')
        user.name = io.read()
        io.write('Digite seu sobrenome:\t')
        user.surname = io.read()
        io.write('Digite seu usuário:\t')
        user.username = io.read()
        io.write('Digite sua nova senha:\t')
        user.password = io.read()
        io.write('Digite permissão do usuário:\t')
        user.permissoes = io.read()
        local err = s.CheckSchema(user,userSchema)
        if err then
                print(s.FormatOutput(err))
                print('Cadastro não inserido na base de dados!')
        else
                path = (user.name)..(user.surname)..os.time(os.date("!*t"))..'.ltr'
                salt.save(user, './'..path)
                table.insert(registro, path)
        end
        io.write('Deseja cadastrar novo registro (s/n)? ')
        resp = io.read()
        continue = resp == 's'
until not continue


salt.save(registro, './registro.ltr')