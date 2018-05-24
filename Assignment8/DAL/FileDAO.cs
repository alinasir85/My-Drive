using Entities;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL
{
    public class FileDAO
    {

        public static int Save(FileDTO f)
        {
            String sqlQuery = sqlQuery = String.Format("INSERT INTO dbo.Files(name,parentfolderid,fileext,filesizeinkb,uploadedon,isactive) VALUES('{0}',{1},'{2}',{3},'{4}',{5})",
                    f.fileName, f.parentFolderId, f.fileExt,f.fileSizeInKb,f.uploadedOn,1);

            using (DBHelper helper = new DBHelper())
            {
                return helper.ExecuteQuery(sqlQuery);
            }
        }

        public static List<FileDTO> GetAllFiles(int parentID)
        {
            var query = String.Format("Select * from dbo.Files Where parentfolderid={0}", parentID);

            using (DBHelper helper = new DBHelper())
            {
                var reader = helper.ExecuteReader(query);
                List<FileDTO> list = new List<FileDTO>();

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


        private static FileDTO FillDTO(SqlDataReader reader)
        {
            var dto = new FileDTO();
            dto.fileId = reader.GetInt32(0);
            dto.fileName = reader.GetString(1);
            dto.parentFolderId = reader.GetInt32(2);
            dto.fileExt = reader.GetString(3);
            dto.fileSizeInKb = reader.GetInt32(4);
            dto.uploadedOn = reader.GetDateTime(5).ToString("yyyy-MM-dd hh:mm:ss");
            dto.IsActive = reader.GetBoolean(6);
            return dto;
        }

        public static int DeleteFile(string fn)
        {
            String sqlQuery = String.Format("Delete FROM dbo.Files Where name='{0}'", fn);

            using (DBHelper helper = new DBHelper())
            {
                return helper.ExecuteQuery(sqlQuery);
            }
        }
    }
}
