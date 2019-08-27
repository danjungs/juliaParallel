'''
Função para testar Lock em julia
Durante a seção critica a thread imprime e espera um certo tempo
'''
using Base.Threads

print_lock = ReentrantLock()

function printing(i)
    println("A Thread $(Threads.threadid()) Parallel task, no Lock")
    lock(print_lock)
    duration = (rand() * 10)
    println("A Thread $(Threads.threadid()) : PrintQueue: Printing a Job during  $(duration) seconds ");
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