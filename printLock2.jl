'''
Função para testar Lock em julia
Durante a seção critica a thread com a macro show informa o tempo de espera e a thread que realiza a funcao
'''
using Base.Threads

print_lock = ReentrantLock()

function printing(i)
    println("A Thread $(Threads.threadid()) Parallel task, no Lock")
    lock(print_lock)
    duration = (rand() * 10)
    @show duration, Threads.threadid()
    sleep(duration)
    unlock(print_lock)
end


function runthreads()
    thread = Task[]
    for i in 1:nthreads()
        push!(thread, Threads.@spawn printing(i))
    end
    for i in 1:length(thread)
        wait(thread[i])
    end
end 