class Membros
    include Enumerable

    def initialize
        @membros = []
    end

    def each
        @membros.each { |membro| yield membro}
    end

    def adicionar(membro)
        @membros << membro
    end

    def remover(membro)
        @membros.delete(membro)
    end

    def broadcast(mensagem, origem)
        destinatarios = @membros - [origem]
        destinatarios.each do |destinatario|
            destinatario.socket.puts("> #{origem.nome}: #{mensagem}")
        end
    end

    def registar(socket)
        socket.print "Inisira o seu nome: "
        nome = socket.gets.chomp
        membro = Membro.new(nome, socket)
        membro.bemvindo(self)
        adicionar(membro)
        broadcast("[Acabou de entrar]", membro)
        membro
    end

    def escutar(membro)
        loop do
            #membro.socket.print("> [Eu]: ")
            mensagem = membro.socket.readline
            broadcast(mensagem, membro)
        end
    end

    def desconectar(membro)
        membro.socket.close
        broadcast("[Saiu da sala]", membro)
        remover(membro) 
    end

end