using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entities
{
    public class FileDTO
    {
        public int fileId { get; set; }
        public String fileName { get; set; }
        public int parentFolderId { get; set; }
        public String fileExt { get; set; }
        public int fileSizeInKb { get; set; }
        public String uploadedOn { get; set; }
        public Boolean IsActive { get; set; }
    }
}
