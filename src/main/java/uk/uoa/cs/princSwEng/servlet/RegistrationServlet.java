package uk.uoa.cs.princSwEng.servlet;

import com.sendgrid.*;
import java.io.IOException;

import uk.uoa.cs.princSwEng.resource.Global;


import uk.uoa.cs.princSwEng.resource.Message;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;
import java.net.URISyntaxException;

import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;

import java.util.List;
import java.util.ArrayList;

import uk.uoa.cs.princSwEng.resource.Researcher;
import uk.uoa.cs.princSwEng.database.CreateResearcherDatabase;

public final class RegistrationServlet extends AbstractDatabaseServlet
{
	private static final long serialVersionUID = 1L;
	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException
	{
		// forwards the control to the ManagerPage
		req.getRequestDispatcher("/jsp/registration.jsp").forward(req, res);
	}
	public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException
	{
		// request parameter
		int rkey = -1;
		// model
		Message m = null;
		String username = null;
		String name = null;
		String surname = null;
		String email = null;
		String password = null;
		try
		{
			System.out.println("Try");
			username = req.getParameter("username");
			name = req.getParameter("name");
			surname = req.getParameter("surname");
			email = req.getParameter("email");
			password = req.getParameter("password");

			if (username == ""|| name == ""|| surname == ""|| email == ""|| password == "") {
				System.out.println("some parameters are empty");
				req.setAttribute("error", "Please ensure all fields are filled out");
				req.getRequestDispatcher("/jsp/registration.jsp").forward(req, res);
			}
			//cpassword = req.getParameter("cpassword");
			if (Global.DEBUGMODE)
				System.out.println("Parameters retrieved: " + username + name + surname + email + password);
			Researcher resea = new Researcher(username, name, surname, email, password);
			rkey = new CreateResearcherDatabase(getConnection(), resea).createResearcher();

		}/* catch (NumberFormatException ex)
		          {
		          m = new Message("Cannot read the company. Invalid input parameters: translator must be a string.",
		          "E100", ex.getMessage());
		          }*/
		catch (SQLException ex)
		{
				m = new Message("Cannot find the company: unexpected error while accessing the database.",
				                "E200", ex.getMessage());
		}
		catch (URISyntaxException ex)
		{
			m = new Message("There is a problem with the URI during the database connection phase.", "DB100", ex.getMessage());
		}
		req.setAttribute("rkey",rkey);
		req.setAttribute("username",username);
		req.setAttribute("name",name);
		req.setAttribute("surname",surname);
		req.setAttribute("email",email);
		HttpSession session = req.getSession(true);
		session.setAttribute("current_logged_in", "rkey");
		req.getRequestDispatcher("/jsp/display-rkey.jsp").forward(req,res);
	}
}
