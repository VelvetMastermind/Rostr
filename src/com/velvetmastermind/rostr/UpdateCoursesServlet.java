package com.velvetmastermind.rostr;
import org.jsoup.Jsoup;
import org.jsoup.parser.*;
import org.jsoup.nodes.*;
import org.jsoup.select.*;
import org.jsoup.examples.*;
import org.jsoup.nodes.Node;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
@SuppressWarnings("serial")
public class UpdateCoursesServlet extends HttpServlet
{
	@Override
	public void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException
	{
		//
		// TOOD - do login (form display)
		//
	}

	@Override
	public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException
	{
		Document doc = Jsoup.connect("http://www4.uwm.edu/schedule/index.cfm?a1=subject_details&subject=COMPSCI&strm=2149").get();
		Elements td = doc.getElementsByTag("table");
		Elements useful = new Elements();
		for(Element element : td){
			String x = element.toString();
			if(x.contains("COMPSCI")){
				useful.add(element);
			}
		}
		useful.remove(0);
		td.clear();
	}
}
