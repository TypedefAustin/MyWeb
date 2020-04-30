package WebPest;
import java.io.*;
import java.net.*;
import java.lang.String;
import java.util.regex.*;

public class Login {
    private URL url;//学校地址
    private String Cookie;//Cookie
    private String Viewstate; //网站验证代码
    private String ID;
    private String password;
    private String name;
    String info;
    int ImgNum;

    public Login() {
        try {
            url = new URL("http://zhjw1.jju.edu.cn:81/");
            ID = "20170203411";
            password = "ljw406044";
            getCookie(url);
            SaveImg();
        }catch (Exception e)
        { e.printStackTrace();}
    }

    public String ReturnCookie() {
        return Cookie;
    }

    public String ReturnViewstate() {
        return Viewstate;
    }

    public String ReturnID() {
        return ID;
    }

    public String Returnpassword() {
        return password;
    }

    public String Returnname() {
        return name;
    }

    public String Outinfo()
    {
        return info;
    }

    public String ReturnImgSrc()
    {
       return (Integer.toString(ImgNum)+".gif");
     }

    public void getCookie(URL url) {
        try {
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            // 设置请求超时时间
            conn.setReadTimeout(1000);
            if (conn.getResponseCode() != 200) {
                System.out.println("error");
            }
            // 获取Set-Cookie
            String str = conn.getHeaderField("Set-Cookie");
            int begin = str.indexOf("ASP.NET_SessionId");
            int end = str.indexOf(';', begin);

            Cookie = str.substring(begin, end);//网页Cookie
            BufferedReader read = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            //读取整个网页的源码
            StringBuffer buffer = new StringBuffer();
            while ((str = read.readLine()) != null) {
                buffer.append(str);
            }
            read.close();
            begin = buffer.indexOf("__VIEWSTATE\"");
            begin = buffer.indexOf("value=\"", begin + 1);
            begin = buffer.indexOf("\"", begin + 1);
            end = buffer.indexOf("\"", begin + 1);
            Viewstate = buffer.substring(begin + 1, end);//网页代码
            System.out.println("01");
            System.out.println(Cookie);
            System.out.println(Viewstate);
        } catch (MalformedURLException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
        }
    }

    public void SaveImg() {
        try {
            /**
             * img变量的值为http://218.197.80.27/CheckCode.aspx
             * 也就是上面图片中，验证码的网址，在浏览器中，右键验证码 即可选择复制图片网址
             */
            URL url = new URL("http://zhjw1.jju.edu.cn:81/CheckCode.aspx");
            HttpURLConnection openConnection = (HttpURLConnection) url.openConnection();
            openConnection.setRequestMethod("GET");
            openConnection.setReadTimeout(5000);
            // cookie一同提交(ASP.NET_SessionId=4kusfii0urpbrazkhxvuas45,只需要等号后面的一串数据)
            openConnection.setRequestProperty("Cookie", Cookie);

            InputStream in = openConnection.getInputStream();
            //必须使用字节流，不能使用字符流，不然图片无法打开
            byte[] by = new byte[50000];

            // 将验证码保存到本地
            ImgNum=(int)(1+Math.random()*(1000-1+1));
            String  ImgSrc="G:\\IDEA\\MyWeb\\out\\artifacts\\MyWeb_war_exploded\\WebContent\\img"+ImgNum+".gif";
            FileOutputStream file = new FileOutputStream(ImgSrc);
            int len = 0;
            while ((len = in.read(by)) != -1) {
                file.write(by, 0, len);
            }
            file.close();
            in.close();
            System.out.println("读取验证码完毕!");
            System.out.println("02");
            System.out.println(Cookie);
            System.out.println(Viewstate);
        } catch (MalformedURLException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }


    public boolean load(String ViewCode) throws IOException {
        //输入保存到本地的验证码图片上的验证码
        System.out.println("03");
        System.out.println(Cookie);
        System.out.println(Viewstate);
        System.out.println("check = " + ViewCode);

        //拼接请求字符串
        String str = "__VIEWSTATE=" + URLEncoder.encode(Viewstate, "gb2312") + "&txtUserName=" + ID + "&Textbox1=&TextBox2="
                + password + "&txtSecretCode=" + ViewCode + "&RadioButtonList1=" + URLEncoder.encode("学生", "gb2312")
                + "&Button1=&lbLanguage=&hidPdrs=&hidsc=";
        ;
        System.out.println("参数列表:" + str);

        //登录提交的网址
        URL url = new URL("http://zhjw1.jju.edu.cn:81/default2.aspx");
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        //Post提交
        conn.setRequestMethod("POST");
        conn.setReadTimeout(5000);
        conn.setUseCaches(false);
        //禁止程序自己跳转到目标网址，必须设置，不然程序会自己响应
        //302返回码，自己请求跳转后的网址，出现Object Had Moved!错误
        conn.setInstanceFollowRedirects(false);
        // 写入cookie
        conn.setRequestProperty("Cookie", Cookie);
        conn.setDoOutput(true);
        OutputStream out = conn.getOutputStream();
        //写入参数
        out.write(str.getBytes());
        out.close();
        //打印返回码
        System.out.println("返回码:" + conn.getResponseCode());
        //打印服务器返回的跳转网址
        System.out.println("Location :" + conn.getHeaderField("Location"));

        BufferedReader read = new BufferedReader(new InputStreamReader(conn.getInputStream(),"GBK"));
        String temp;
        //读取页面源码
        StringBuffer ab = new StringBuffer();
        while ((temp = read.readLine()) != null) {
            ab.append(temp);
        }
        System.out.println(ab);
        if (conn.getResponseCode() != 302) {
            //getError为自定义函数，提取出错误信息
           info=getError(ab.toString());
            return false;


        }
        name = getNameByUrl(conn.getHeaderField("Location"));
        return true;
    }


    /**
     * 获取名字
     *
     * @param url
     * @return
     */
    public String getNameByUrl(String url) {
        String name1="";
        url = "http://zhjw1.jju.edu.cn:81/" + url;
        try {
            URL Url = new URL(url);
            HttpURLConnection conn = (HttpURLConnection) Url.openConnection();

            conn.setRequestMethod("GET");
            conn.setReadTimeout(2000);
            conn.setRequestProperty("Cookie", Cookie);

            @SuppressWarnings("Duplicates") BufferedReader read = new BufferedReader(new InputStreamReader(
                    conn.getInputStream(),"GBK"));

            StringBuffer sb = new StringBuffer();
            String temp;
            while ((temp = read.readLine()) != null) {
                sb.append(temp);
            }

            Pattern pattern = Pattern.compile("xm=[\\w\\W]*?&");
            Matcher matcher = pattern.matcher(sb.toString());

            matcher.find();
            name1 = sb.substring(matcher.start() + 3, matcher.end()-1);
            return name1;

        } catch (MalformedURLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return name1;
    }

    private static String getError(String html) {

        Pattern pattern = Pattern.compile("alert.*?\\)");
        Matcher matcher = pattern.matcher(html);
        if (!matcher.find())
            return "未定义错误";
        return html.substring(matcher.start() + 7, matcher.end() - 2);
    }
}
