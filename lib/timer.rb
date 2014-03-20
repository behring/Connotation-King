  Thread.new {



  timers = Timers.new
  every_five_seconds = timers.every(5) { 
    
    puts JOKE_DEFAULT_URL
    puts CARTOON_DEFAULT_URL
    
    cartoon = GrabData.grab_cartoon(CARTOON_DEFAULT_URL)
    joke = GrabData.grab_joke(JOKE_DEFAULT_URL)

    
    puts "#{cartoon.title}"
    puts "#{joke.title}"
    puts "5 seconds grab data once" 

  }
  loop { timers.wait }

    
  }


