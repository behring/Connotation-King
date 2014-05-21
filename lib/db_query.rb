module DBQuery

  def self.count_joke
    Joke.count
  end

  def self.count_cartoon
    Cartoon.count
  end

  def self.count_jzw
    Jzw.count
  end

  def self.count_music
    Music.count
  end


  def self.get_random_joke(form_user_name,user_input_content)
    if Joke.count>0
      # joke = Joke.first(:order => "RANDOM()")
      offset = rand(Joke.count)
      joke = Joke.first(:offset => offset)
      is_exist = DBQuery.exist_users_database(form_user_name,
                                              DataType::JOKE,joke.id)
      if is_exist
        get_random_joke(form_user_name,user_input_content)
      else
        user = User.new
        user.identity_user = form_user_name
        user.input_content = user_input_content
        user.data_type = DataType::JOKE
        user.data_id = joke.id
        DBAdd.add_user_data(user)
        joke
      end
    else
      nil
    end
  end


  def self.get_random_cartoon(form_user_name,user_input_content)
    if Cartoon.count>0
     cartoon =  Cartoon.first(:order => "RANDOM()")
      is_exist = DBQuery.exist_users_database(form_user_name,
                                              DataType::CARTOON,cartoon.id)
      if is_exist
        get_random_cartoon(form_user_name,user_input_content)
      else
        user = User.new
        user.identity_user = form_user_name
        user.input_content = user_input_content
        user.data_type = DataType::CARTOON
        user.data_id = cartoon.id
        DBAdd.add_user_data(user)
        cartoon
      end
    else
      nil
    end
  end


  def self.get_random_jzw(form_user_name,user_input_content)
    if Jzw.count>0
      jzw = Jzw.first(:order => "RANDOM()")
      is_exist = DBQuery.exist_users_database(form_user_name,
                                              DataType::JZW,jzw.id)
      if is_exist
        get_random_jzw(form_user_name,user_input_content)
      else
        user = User.new
        user.identity_user = form_user_name
        user.input_content = user_input_content
        user.data_type = DataType::JZW
        user.data_id = jzw.id
        DBAdd.add_user_data(user)
        jzw
      end
    else
      nil
    end
  end

  def self.get_jzw_answer(form_user_name,jzw_id = -1)
    if jzw_id == -1
      user = User.where("identity_user = ? AND data_type = ?",form_user_name,DataType::JZW).last
      Jzw.find_by(:id => user.data_id).answer
    else
      Jzw.find_by(:id => jzw_id).answer
    end

  end


  def self.get_music(singer,song)
    music = Music.where("singer = ? AND song = ?",singer, song).first
  end


  def self.exist_users_database(identity_user,data_type,data_id)
    #User.find_by(:identity_user => identity_user,:data_type=>data_type,
    #:data_id=>data_id)

    count = User.where("identity_user = ? AND data_type = ? AND data_id = ?",
            identity_user,data_type,data_id).count
    if count>0
      true
    else
      false
    end
  end


end