package docswarm;


import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.RequestMapping;

@RestController
public class TestController {

    @RequestMapping("/")
    public String index() {
        return "Service...Root index API returned..need to work on build:-) \n";
    }
	
}
