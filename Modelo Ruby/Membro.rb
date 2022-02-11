class Membro

    attr_reader :nome, :socket

    def initialize(nome, socket)
      @nome = nome
      @socket = socket
    end

    def bemvindo(membros)
        socket.puts "Bem vindo, #{nome}!" # socket.puts ? 
        socket.puts "De momento estão #{membros.count} utilizadores online."
    end


end