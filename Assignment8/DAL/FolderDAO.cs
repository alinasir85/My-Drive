using Entities;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL
{
    public class FolderDAO
    {

        public static int Save(FolderDTO f)
        {
            String sqlQuery = sqlQuery = String.Format("INSERT INTO dbo.Folder(name,parentfolderid,createdon,isactive) VALUES('{0}',{1},'{2}',{3})",
                    f.folderName,f.parentFolderId, f.createdOn,1);

            using (DBHelper helper = new DBHelper())
            {
                return helper.ExecuteQuery(sqlQuery);
            }
        }

        public static List<FolderDTO> GetAllFolders(int parentID)
        {
            var query =String.Format("Select * from dbo.Folder Where IsActive = 1 AND parentfolderid={0}",parentID);

            using (DBHelper helper = new DBHelper())
            {
                var reader = helper.ExecuteReader(query);
                List<FolderDTO> list = new List<FolderDTO>();

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


        public static List<FolderDTO> GetAllFolders2(int ID)
        {
            var query = String.Format("Select * from dbo.Folder Where IsActive = 1 AND id={0}", ID);

            using (DBHelper helper = new DBHelper())
            {
                var reader = helper.ExecuteReader(query);
                List<FolderDTO> list = new List<FolderDTO>();

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

        public static string getFoldernameByid(int id)
        {
            string query = "select * from dbo.Folder where id='" + id + "'";
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

        public static int getParentFolderid(int id)
        {
            string query = "select * from dbo.Folder where id='" + id + "'";
            using (DBHelper helper = new DBHelper())
            {
                int pid=-1;
                var reader = helper.ExecuteReader(query);
                if (reader.Read())
                {
                    pid = reader.GetInt32(reader.GetOrdinal("parentfolderid"));
                }
                return pid;
            }
        }

        private static FolderDTO FillDTO(SqlDataReader reader)
        {
            var dto = new FolderDTO();
            dto.folderId = reader.GetInt32(0);
            dto.folderName = reader.GetString(1);
            dto.parentFolderId = reader.GetInt32(2);
            dto.createdOn = reader.GetDateTime(3).ToString("yyyy-MM-dd hh:mm:ss");
            dto.IsActive = reader.GetBoolean(4);
            return dto;
        }

        public static int DeleteFolder(int fid)
        {
            String sqlQuery = String.Format("Delete FROM dbo.Folder Where id={0}", fid);

            using (DBHelper helper = new DBHelper())
            {
                return helper.ExecuteQuery(sqlQuery);
            }
        }

    }
}
