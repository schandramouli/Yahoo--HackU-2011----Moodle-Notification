<?php


    /*
     * Php page to check the updates on any of the moodle website
     */
    
    require_once('simplehtmldom_1_5/simple_html_dom.php');
    
    // Taking the main url
    $url = "http://localhost/~aditya/moodle/";
    // Takes the cookies to login into the website To be entered by the user
    $cookies ="" ;


    $curl = curl_init($url);
    curl_setopt( $curl, CURLOPT_COOKIE, $cookies);
    curl_setopt($curl, CURLOPT_RETURNTRANSFER, 1);
    
    $html = curl_exec($curl);
    
    $name = new simple_html_dom();
    $name = str_get_html( $html );
    $div1 = $name->find('td');

    
    foreach( $div1 as $tmp=>$div2 )
    {
      if($div2->id == 'middle-column' ) 
      {
        $temp = new simple_html_dom();
        $temp = str_get_html ( $div2 );
        $div2 = $temp->find('a');
        
        $counttt=0;
        foreach( $div2 as $div )
        {
        $counttt++;
         if( strpos( $div->href, 'course/view.php' ) ) 
         {
            $new = new simple_html_dom();
            
            $curl = curl_init($div->href);
            curl_setopt( $curl, CURLOPT_COOKIE, $cookies);
            curl_setopt($curl, CURLOPT_RETURNTRANSFER, 1);
            
            $html = curl_exec($curl);
            $id = 'class';
            $new = str_get_html( $html );
            
            $temp1 = $new->find('div');
            foreach( $temp1 as $finale )
            {
                 if($finale->$id == "block_recent_activity sideblock")
                 {
                    $echo = new simple_html_dom();
                    $echo = str_get_html( $finale );
                    $php = $echo->find('div div p');
                    foreach( $php as $c ) { if( !strpos( $c, 'Nothing new since your last login') ) echo $div->plaintext.' : '.$c->plaintext.'\n'; }
                 }
            }
          }
        }
        break;
      }
   }
return 0;


/*
    This is required with the curl fields if we want to have the proxy authentication
    curl_setopt($curl, CURLOPT_PROXYAUTH, CURLAUTH_NTLM );  
    curl_setopt($curl, CURLOPT_MAXREDIRS, 10 );  
    curl_setopt($curl, CURLOPT_VERBOSE, TRUE );  
    curl_setopt($curl, CURLOPT_PROXYUSERPWD, '<username>:<password>' );  
    curl_setopt($curl, CURLOPT_PROXY, "http://<full port address>"); */
    
?>
