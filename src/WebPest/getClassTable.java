package WebPest;

import java.io.*;
import java.net.*;
import java.lang.String;

public class getClassTable {


    public static void getKB(String[] Date) throws UnsupportedEncodingException {
        String cookie = Date[0];
        String xh = Date[3];
        String name = Date[4];
        System.out.println("读取课表");
        String url = "http://zhjw1.jju.edu.cn:81/xskbcx.aspx?xh=" + xh + "&xm="
                + URLEncoder.encode(name, "GB2312") + "&gnmkdm=N121603";

        System.out.println("获取课表的参数: " + url);
        URL Url;
        try {
            Url = new URL(url);
            HttpURLConnection conn = (HttpURLConnection) Url.openConnection();

            conn.setRequestMethod("GET");
            conn.setReadTimeout(2000);
            conn.setRequestProperty("Cookie", cookie);
            conn.setRequestProperty("Referer",
                    "http://zhjw1.jju.edu.cn:81/xs_main.aspx?xh=" + xh);
            conn.setInstanceFollowRedirects(false);
            conn.setDoOutput(true);
            BufferedReader read = new BufferedReader(new InputStreamReader(
                    conn.getInputStream(),"GBK"));

            StringBuffer sb = new StringBuffer();
            String temp;
            while ((temp = read.readLine()) != null) {
                sb.append(temp);
            }
            //打印出含有课表的网页源码
            System.out.println(sb);
            try {
                BufferedOutputStream out = new BufferedOutputStream(new FileOutputStream("./Classtable.txt"));
                //读取数据
                //一次性取多少字节
                String Html = new String(sb);
                out.write(Html.getBytes(), 0, Html.length());
                out.flush();
                out.close();
            }catch (Exception e){
                e.printStackTrace();
            }


        } catch (MalformedURLException e) {
            e.printStackTrace();
        } catch (ProtocolException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
