using Entities;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Text;
using System.Threading.Tasks;

namespace DAL
{
    public class UserDAO
    {
        
        
        public static UserDTO ValidateUser(String pLogin, String pPassword)
        {
            var query = String.Format("Select * from dbo.Users Where Login='{0}' and Password='{1}'", pLogin, pPassword);

            using (DBHelper helper = new DBHelper())
            {
                var reader = helper.ExecuteReader(query);

                UserDTO dto = null;

                if (reader.Read())
                {
                    dto = FillDTO(reader);
                }

                return dto;
            }
        }

        public static UserDTO GetUserById(int pid)
        {

            var query = String.Format("Select * from dbo.Users Where UserId={0}", pid);

            using (DBHelper helper = new DBHelper())
            {
                var reader = helper.ExecuteReader(query);

                UserDTO dto = null;

                if (reader.Read())
                {
                    dto = FillDTO(reader);
                }

                return dto;
            }
        }

        public static List<UserDTO> GetAllUsers()
        {
            using (DBHelper helper = new DBHelper())
            {
                var query = "Select * from dbo.Users Where IsActive = 1;";
                var reader = helper.ExecuteReader(query);
                List<UserDTO> list = new List<UserDTO>();

                while (reader.Read())
                {
                    var dto = FillDTO(reader);
                    if (dto != null)
                    {
                        list.Add(dto);
                    }
                }

                return list;
            }
        }


        private static UserDTO FillDTO(SqlDataReader reader)
        {
            var dto = new UserDTO();
            dto.UserID = reader.GetInt32(0);
            dto.Name = reader.GetString(1);
            dto.Login = reader.GetString(2);
            dto.Password = reader.GetString(3);
            dto.email = reader.GetString(4);
            return dto;
        }


        public static int getUserId(string login)
        {
            string query = "select * from dbo.Users where Login='" + login + "'";
            using (DBHelper helper = new DBHelper())
            {
                int id = 0;
                var reader = helper.ExecuteReader(query);
                if (reader.Read())
                {
                    id = reader.GetInt32(reader.GetOrdinal("UserID"));
                }
                return id;
            }
        }

        public static bool isEmailExist(string email)
        {

            string query = "select * from dbo.Users where Email='" + email + "' ";
            using (DBHelper helper = new DBHelper())
            {
                var reader = helper.ExecuteReader(query);
                if (reader.Read())
                    return true;
                return false;
            }

        }


        public static bool sendEmail(String toEmailAddress, String subject, String body)
        {
            try
            {
                String fromDisplayEmail = "bsef15m014@gmail.com";
                String fromPassword = "punjabuniversity";
                String fromDisplayName = "ADMIN";
                MailAddress fromAddress = new MailAddress(fromDisplayEmail, fromDisplayName);
                MailAddress toAddress = new MailAddress(toEmailAddress);
                System.Net.Mail.SmtpClient smtp = new System.Net.Mail.SmtpClient
                {
                    Host = "smtp.gmail.com",
                    Port = 587,
                    EnableSsl = true,
                    DeliveryMethod = System.Net.Mail.SmtpDeliveryMethod.Network,
                    UseDefaultCredentials = false,
                    Credentials = new NetworkCredential(fromAddress.Address, fromPassword)


                };

                using (var message = new MailMessage(fromAddress, toAddress)
                {
                    Subject = subject,
                    Body = body
                })
                {
                    smtp.Send(message);
                }
                return true;
            }
            catch (Exception ex)
            {
                return false;
            }
        }


        public static UserDTO getUserByEmail(string email)
        {
            UserDTO u = new UserDTO();
            string query = "select * from dbo.Users where Email='" + email + "'";

            using (DBHelper helper = new DBHelper())
            {
                var reader = helper.ExecuteReader(query);

                UserDTO dto = null;

                if (reader.Read())
                {
                    dto = FillDTO(reader);
                }

                return dto;
            }
        }

        public static bool isUserExist(string login, string email)
        {
            string query = "select * from dbo.Users where Login='" + login + "' OR Email='" + email + "' ";
            using (DBHelper helper = new DBHelper())
            {
                var reader = helper.ExecuteReader(query);
                if (reader.Read())
                    return true;
                return false;
            }
        }

        public static string getUsernameByid(int id)
        {
            string query = "select * from dbo.Users where UserID='" + id + "'";
            using (DBHelper helper = new DBHelper())
            {
                String name = "";
                var reader = helper.ExecuteReader(query);
                if (reader.Read())
                {
                    name = reader.GetString(reader.GetOrdinal("Name"));
                }
                return name;
            }
        }

        public static UserDTO getUserByName(string name)
        {
            UserDTO u = new UserDTO();
            string query = "select * from dbo.Users where Name='" + name + "'";

            using (DBHelper helper = new DBHelper())
            {
                var reader = helper.ExecuteReader(query);

                UserDTO dto = null;

                if (reader.Read())
                {
                    dto = FillDTO(reader);
                }

                return dto;
            }
        }
    }
}
