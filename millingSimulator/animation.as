import flash.events.TimerEvent;
import flash.utils.Timer;
import flash.events.MouseEvent;
import flash.media.Sound;
import flash.net.URLRequest;
import ParamCalculator;
import flash.media.SoundChannel;

var drum:machineSound = new machineSound();
var channel:SoundChannel = new SoundChannel();
var minuteTimer:Timer = new Timer(10);
var minutes:int = 0;
var cogSpeed:Number;
var feed:Number;
var subTime:int = 0;
chips.alpha = 0;
chips2.alpha = 0;
chips3.alpha = 0;
var flyingChip:int = 1;
minuteTimer.addEventListener(TimerEvent.TIMER, startAnimation);
runSim.addEventListener(MouseEvent.CLICK, startSimulation);

function startAnimation(evt:TimerEvent):void{
	minutes +=1;
	var cogRot:int = int(Math.ceil((cogSpeed*10000)/60000));
	var feedWork:int = int(feed*10);
	millingCog.rotation += cogRot;
	workpiece.x += feedWork;
	var timeToReachMill:Number = 0;
	timeToReachMill = Math.ceil((277*1)/feedWork);
	var timeToWorkpiece:Number;
	timeToWorkpiece = Math.ceil(((277+598)*1)/feedWork)
	var timeToTransverse:Number;
	timeToTransverse = Math.ceil((1100)*1/feedWork);
	trace(timeToReachMill);
	if(minutes >= timeToTransverse){
		minuteTimer.stop();
		channel.stop();
	}else{
		if((minutes >= timeToReachMill) &&  (minutes <= timeToWorkpiece)){
			if(flyingChip == 1 && subTime <= 3 ){
				//Chips 1
				chips.alpha = 1;
				chips.x -= Math.ceil(cogRot/3);
				chips.y -= Math.ceil(cogRot/3);
				//Chips 3
				chips3.alpha = 0;
				chips3.x = 272;
				chips3.y = 239;
				if(subTime == 3){
					subTime = 0;
					flyingChip = 2;
				}else{
					subTime += 1;
				}
			}else if(flyingChip == 2 && subTime <= 3){
				//Chips 2
				chips2.alpha = 1;
				chips2.x -= Math.ceil(cogRot/3);
				chips2.y -= Math.ceil(cogRot/3);
				//Chips 1
				chips.alpha = 0;
				chips.x = 272;
				chips.y = 239;
				if(subTime == 3){
					subTime = 0;
					flyingChip = 3;
				}else{
					subTime += 1;
				}
			}else if(flyingChip == 3 && subTime <= 3){
				//Chips 3
				chips3.alpha = 1;
				chips3.x -= Math.ceil(cogRot/3);
				chips3.y -= Math.ceil(cogRot/3);
				//Chips 1
				chips2.alpha = 0;
				chips2.x = 272;
				chips2.y = 239;
				if(subTime == 3){
					subTime = 0;
					flyingChip = 1;
				}else{
					subTime += 1;
				}
			}
		}else{
			chips.alpha = 0;
			chips2.alpha = 0;
			chips3.alpha = 0;
		}
	}
}
function startSimulation(evt:MouseEvent):void{
	var calc:ParamCalculator = new ParamCalculator();
	//Getting the inputs
	try{
		var spindleSpeedn:Number = parseInt(spindleSpeed.text);
		var toolDiam:Number = parseInt(toolDiameter.text);
		var engAngle:Number = parseInt(engagementAngle.text);
		var numCuttingEdge:Number = parseInt(numCuttingEdges.text);
		var axialDofCut:Number = parseInt(axialDepthofCut.text);
		var timeTake:Number = parseInt(timeTaken.text);
		var feedpt:int = feedPerTooth.selectedIndex;
		var materiali:int = material.selectedIndex;
		if(isNaN(spindleSpeedn) || isNaN(toolDiam) || isNaN(engAngle) || isNaN(numCuttingEdge) || isNaN(axialDofCut) || isNaN(timeTake)){
			errorLabel.text = "<error>: One or more input might be invalid";
		}else{
			//Doing the Maths
			var speCutf:Number = calc.specificForce(materiali,feedpt);
			var feedSp:Number = calc.FeedSpeed(feedpt);
			var lenChip:Number = calc.lengthOfChipCut(spindleSpeedn,toolDiam);
			var millTime:Number = calc.millingTime(timeTake,lenChip,feedSp);
			var cuttinSp:Number = calc.cuttingSpeed(toolDiam,spindleSpeedn);
			var lenofC:Number = calc.lengthOfChipCut(spindleSpeedn, toolDiam);
			var radDOC:Number = calc.radialDephtOfCut(engAngle,toolDiam);
			var materialRR:Number = calc.materialRemovalRate(radDOC, axialDofCut, feedSp);
			var avrChipThick:Number = calc.averageChipThickness(feedSp, radDOC, toolDiam);
			var maxUThick:Number = calc.maxUncutChipThickness(feedSp,radDOC,toolDiam);
			sCuttingForce.text = speCutf.toString()+"N/mm^2";
			millingTime.text = millTime.toString()+"sec";
			materialRemRate.text = materialRR.toString()+"mm/sec";
			LengthOfCut.text = lenofC.toString()+"mm";
			AverageChipThickness.text = avrChipThick.toString()+"mm";
			MaxUncutThickness.text = maxUThick.toString()+"mm";
			FeedPTooth.text = feedPerTooth.selectedItem.label;
			radialDepth.text = radDOC.toString();
			cuttingSpeed.text = cuttinSp.toString()+"mm/sec";
			trace(feedSp);
			//// If everything is right, start the Animation
			//re-initialize params
			minutes = 0;
			workpiece.x = -299;
			workpiece.y = 251;
			chips.x = 272;
			chips.y = 239;
			chips2.x = 272;
			chips2.y = 239;
			chips3.x = 272;
			chips3.y = 239;
			chips.alpha = 0;
			chips2.alpha = 0;
			chips3.alpha = 0;
			cogSpeed = spindleSpeedn;
			feed = feedSp;
			minuteTimer.start();
			channel = drum.play();
		}
	}catch(err:Error){
		errorLabel.text = err.message;
	}
}