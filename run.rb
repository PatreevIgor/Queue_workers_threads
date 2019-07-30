class Worker
  attr_reader   :worker_name
  attr_accessor :status


  def initialize(worker_name)
    @worker_name  = worker_name
    @status = false
    puts "Worker name #{@worker_name} is created!"
  end

  def run_process
    sec = rand(5..20)
    puts "Run process with #{sec} secoonds!"

    sleep sec
  end

end


servers = ['server1', 'server2', 'server3']

$workers = []

servers.each do |server|
  $workers << Worker.new(server)
end

def first_free_worker_name
  inst_worker_name = nil

  loop do
    sleep 1

    $workers.each do |worker|
      if worker.status == true
        next
      else
        inst_worker_name = worker.worker_name
        break
      end
    end



    break if inst_worker_name != nil

  end

  puts "Finded free worker = #{inst_worker_name}"
  inst_worker_name
end

def free_worker_exist?
  free_worker = false
  $workers.each do |worker|
    free_worker = true if worker.status == false
  end

  free_worker
end



tags = { 'c1'=>5,'c2'=>1,'c3'=>3,'c4'=>4,'c5'=>8,'c6'=>10,'c7'=>1,'c8'=>3,'c9'=>2, 'c10' => 5 }

tags.each do |tag, sec|

  puts "current tag - #{tag}"

  loop do
    sleep 0.5
    puts 'sleep 0.5'

    run = false

    puts "free_worker_exist? = #{free_worker_exist?}"
    if free_worker_exist?

      $workers.each do |worker|

        if worker.worker_name == first_free_worker_name
              Thread.new {
                puts "START process for worker with name - #{worker.worker_name}"
                worker.run_process

                puts "FINISH process for worker with name - #{worker.worker_name}"
                worker.status = false
              }

              worker.status = true

            break
              # sleep 1
              # puts "worker.status ===>>> - #{worker.status}"
        end
      end

      run = true
    end

  break if run
  end

end
