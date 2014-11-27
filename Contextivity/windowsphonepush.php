<?php 
/**
*Windows Phone 7 Push Notification in php by Rudy HUYN
**/

class WindowsPhonePushDelay
{
const Immediate=0;
const In450Sec=10;
const In900Sec=20;
}


class WindowsPhonePushNotification
{
    private $notif_url = '';
 
    function WindowsPhonePushNotification($notif_url)
    {
        $this->notif_url = $notif_url;
    }
 
    public function send_raw($msg,$message_id=NULL, $delay = WindowsPhonePushDelay::Immediate)
    {
        return $this->send_push(NULL,$delay+3,$message_id, $msg);
    }
 
    public function send_tile($image_url, $title, $count,$message_id=NULL, $delay = WindowsPhonePushDelay::Immediate)
    {
        $msg = 	"<?xml version=\"1.0\" encoding=\"utf-8\"?>" .
				"<wp:Notification xmlns:wp=\"WPNotification\">" .
				"<wp:Tile>" .
				"<wp:BackgroundImage>$image_url</wp:BackgroundImage>" .
				"<wp:Count>$count</wp:Count>" .
				"<wp:Title>$title</wp:Title>" .
				"</wp:Tile>" .
				"</wp:Notification>";
       
	return $this->send_push('token',$delay+1, $message_id,$msg);
    }
 
    public function send_toast($title, $message,$message_id=NULL, $delay = WindowsPhonePushDelay::Immediate)
    {
        $msg =	"<?xml version=\"1.0\" encoding=\"utf-8\"?>" .
				"<wp:Notification xmlns:wp=\"WPNotification\">" .
				"<wp:Toast>" .
				"<wp:Text1>$title</wp:Text1>" .
				"<wp:Text2>$message</wp:Text2>" .
				"</wp:Toast>" .
				"</wp:Notification>";
 
        return $this->send_push('toast',$delay+2,$message_id, $msg);
    }
 
    private function send_push($target,$delay,$message_id,$msg)
    {
		$sendedheaders=  array(
                            'Content-Type: text/xml',
                            'Accept: application/*',
							"X-NotificationClass: $delay"
                            );
		if($message_id!=NULL)
		$sendedheaders[]="X-MessageID: $message_id";
		if($target!=NULL)
		$sendedheaders[]="X-WindowsPhone-Target:$target";
		
		
		$req = curl_init();
        curl_setopt($req, CURLOPT_HEADER, true); 
		curl_setopt($req, CURLOPT_HTTPHEADER,$sendedheaders); 
        curl_setopt($req, CURLOPT_POST, true);
        curl_setopt($req, CURLOPT_POSTFIELDS, $msg);
        curl_setopt($req, CURLOPT_URL, $this->notif_url);
        curl_setopt($req, CURLOPT_RETURNTRANSFER, 1);
		$response = curl_exec($req);
		curl_close($req);
 
		$result=array();
		foreach(explode("\n",$response) as $line)
		{
		$tab=explode(":",$line,2);
		if(count($tab)==2)
			$result[$tab[0]]=trim($tab[1]);
		}
		return $result;
     }
}

?>