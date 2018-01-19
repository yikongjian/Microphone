package 
{
	import flash.display.Sprite;
	import flash.events.SampleDataEvent;
	import flash.events.TimerEvent;
	import flash.events.Event;
	import flash.media.SoundChannel;
	import flash.net.URLRequest;
	import flash.media.Sound;
	import flash.utils.Timer;
	import flash.utils.ByteArray;
	import flash.media.SoundMixer;
	import flash.media.Microphone;
	import flash.external.ExternalInterface;


	public class FlashTest extends Sprite
	{
		private var url:String;
		private var request:URLRequest;
		private var s:Sound;
		private var song:SoundChannel;
		private var ba:ByteArray;
		private var gr:Sprite;
		private var time:Timer;
		private var micBytes:ByteArray;
		private var soundBytes:ByteArray;

		public function FlashTest()
		{

			

			//this.url="1.mp3";
			//this.request=new URLRequest(url);
			this.s=new Sound();
			//this.s.addEventListener(Event.COMPLETE, completeHandler);
			//this.s.load(request);
			//this.song=s.play();
			//this.song.addEventListener(Event.SOUND_COMPLETE, soundCompleteHandler);
            Init();
			this.ba=new ByteArray();
			this.gr=new Sprite();
			this.gr.x = 0;
			this.gr.y = 143;
			stage.addChild(gr);
			//            this.time=new Timer(10);
			//            this.time.addEventListener(TimerEvent.TIMER, timerHandler);
			//            this.time.start();



//			function completeHandler(event:Event):void
//			{
//				event.target.play();
//			}
//			function soundCompleteHandler(event:Event):void
//			{
//				this.time.stop();
//			}
			function timerHandler(event:Event):void
			{
				soundBytes= new ByteArray();
				SoundMixer.computeSpectrum(soundBytes, true);
				var i:int;
				gr.graphics.clear();
				gr.graphics.lineStyle(0,0x007ebf);
				gr.graphics.beginFill(0x007ebf,0.5);
				gr.graphics.moveTo(0,0);
/*				var w:int = 5;
				var count:int =0;
				var avg:int =0;
				for (i=0; i<2048; i+=w)
				{
					//avg+=
					var t:Number = soundBytes.readFloat();
					var n:Number=(t*100);
					gr.graphics.drawRect(i, 0, w, -n);
					//count+=1
				}*/
				var w:int = 5;
				var count:int =0;
				var avg:int =0;
				for (i=0; i<512; i+=1)
				{
					var n:Number
					//trace(i)
					if(i<256)
					{
						var t:Number = soundBytes.readFloat();
						n=(t*100);
					} else 
					{
						n=0
					}
					
					avg+=n;
					if(i%7==0){
						n=avg/7
						gr.graphics.drawRect(count*5, 0, w, -n*1.6);
						avg=0
						count+=1
					}					
				}
			}
			function InitMic():void
			{
				var mic:Microphone = Microphone.getMicrophone();
				if (mic)
				{
					mic.setLoopBack(false);
					mic.rate = 44;
					mic.gain = 60;
					mic.addEventListener(SampleDataEvent.SAMPLE_DATA, micSampleDataHandler);
				}
				else
				{
					ExternalInterface.call("WSE.TesterTips('warnning','Sorry,We cannot detect your microphone, Please insert it and try again')"); 
				}

			}

			function micSampleDataHandler(event:SampleDataEvent):void
			{
				micBytes = event.data;
				song = s.play();
				//song.addEventListener(SampleDataEvent.SAMPLE_DATA, soundSampleDataHandler);
			}
			 function InitSound():void {
 			 	s = new Sound();
 				s.addEventListener(SampleDataEvent.SAMPLE_DATA, soundSampleDataHandler);
			}
			function Init(event:Event = null):void
			{
				removeEventListener(Event.ADDED_TO_STAGE, Init);
				InitMic();
				InitSound();
				addEventListener(Event.ENTER_FRAME, timerHandler);
				
				//InitSound();
				//addEventListener(Event.ENTER_FRAME, drawLines);
			}
			function soundSampleDataHandler(event:SampleDataEvent):void
			{
				for (var i:int = 0; i < 8192 && micBytes.bytesAvailable >0; i++)
				{
					var sample:Number = micBytes.readFloat();
					event.data.writeFloat(sample);
					event.data.writeFloat(sample);
				}
			}
		}
	}
}