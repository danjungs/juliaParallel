'''
Função para testar Lock em julia
Durante a seção critica a thread ou irá ler ou escrever em uma variável.
'''
using Base.Threads
using Random.bitrand

print_lock = ReentrantLock()
a = [1]

function readOrWrite()
    lock(print_lock)
    choice = bitrand()[1]
    b= a[1];
    choice ? a[1] = rand(1:10) : a[1] = a[1]
    println("Thread $(Threads.threadid()) Opreação: $(choice) Antes: $(b) Depois: $(a[1])");
    unlock(print_lock)
end


function runthreads()
    thread = Task[]
    for i in 1:nthreads()
        push!(thread, Threads.@spawn readOrWrite())
    end
    for i in 1:length(thread)
        wait(thread[i])
    end
end 