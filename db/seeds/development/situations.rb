
#状況テーブルに紐づくサンプルデータを作成する。

User.create(email: 'hiraoka@gmail.com', password: '12345678', password_confirmation: '12345678')
#状況
Situation.create({:where=>"どこでー？", :with_whom=>"だれと", :what_have_you_been_doing=>"何をしているとき", :occured_time=>"201507312143245", \
  :user_id=>1, :mood_status=>2})
situation = Situation.find(1)


#そのときの気持ちid=1 #####################################################
GivenTimeFeeling.create({:feeling=>Feeling.find(2), :situation=>Situation.find(1), :percentage=>80})
geiven_time_feeling1 = GivenTimeFeeling.find(1)

#自動思考
AutomaticThought.create({:given_time_feeling=>geiven_time_feeling1, :contents=>"どうして積極的になれないのだろう。こんなことでは仕事が進まない"})
automatic_thought1 = AutomaticThought.find(1)
#自動思考　歪みのパターン
DistortionPattern.create({:cognitive_distortion=>CognitiveDistortion.find(3), :automatic_thought=>automatic_thought1})
#根拠
Basis.create({:automatic_thought=>automatic_thought1, :contents=>"仕事の内容がよく分からない。実際に仕事が停滞している。"})
#反証
Rebuttal.create({:automatic_thought=>automatic_thought1, :contents=>"なれていない仕事には誰でも戸惑うが、少し慣れてきた部分もある。同僚も上司も時間があるときには教えてくれるし、少しずつは仕事も進んでいる。"})
#適応的思考
AdaptiveThought.create({:automatic_thought=>automatic_thought1, :contents=>"どんな仕事でもうまくいかないこともあるが少しづつ仕事は進んでいるから、まずその経過を見ることが大切だ。慣れてくればスムーズに行きそうだし周りの人も協力的だ。"})
#気持ちの変化

#そのときの気持ち　id=2####################################################

GivenTimeFeeling.create({:feeling=>Feeling.find(5), :situation=>Situation.find(1),  :percentage=>60})
geiven_time_feeling2 = GivenTimeFeeling.find(2)

#自動思考
AutomaticThought.create({:given_time_feeling=>geiven_time_feeling2, :contents=>"引っ込み思案な自分が情けない。仕事も人間もうまくできない自分は社会人として失格だ"})
automatic_thought2 = AutomaticThought.find(2)
#自動思考　歪みのパターン
DistortionPattern.create({:cognitive_distortion=>CognitiveDistortion.find(6), :automatic_thought=>automatic_thought2})
#根拠
Basis.create({:automatic_thought=>automatic_thought2, :contents=>"人に話しかけるときに緊張する。言いたいことが言えないことがよくある"})
#反証
Rebuttal.create({:automatic_thought=>automatic_thought2, :contents=>"自分は聞き上手だと言われることもある。ためらっていても、本当に必要なことは最後には言えている。"})
#適応的思考
AdaptiveThought.create({:automatic_thought=>automatic_thought2, :contents=>"緊張するのは事実だが、言うべきことを言えればいい。むしろ聞き上手の方が人間関係はうまくいく"})

#気持ちの変化
