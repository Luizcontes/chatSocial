require 'socket'
require './Membros'
require './Membro'

server = TCPServer.new(2000)

puts "Servidor conectado na porta 2000"

membros = Membros.new


while true 
    socket_tcp = server.accept 
    Thread.new(socket_tcp) do |socket|
        membro = membros.registar(socket)
        begin
            membros.escutar(membro)
        rescue EOFError
            membros.desconectar(membro)
        end
    end
end 

=begin 
while true
    socket_tcp = server.accept 
    Thread.new(socket_tcp) do |socket|

        

        begin
            socket.print "Inisira o seu nome: "
            nome = socket.gets.chomp
            membro = Membro.new(nome, socket)
            membro.bemvindo(membros)
            membros.adicionar(membro)
            membros.broadcast("[Acabou de entrar]", membro)
            loop do
                mensagem = socket.readline
                membros.broadcast(mensagem, membro)
            end
            
        rescue EOFError
            socket.close
            membros.remover(membro)
            membros.broadcast("[Saiu da sala]", membro)
        end

        #socket.close
    end 
end 
=end


# print "Que tal?"
# resposta = gets
# puts resposta