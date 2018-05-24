using DAL;
using Entities;
using PdfSharp.Drawing;
using PdfSharp.Pdf;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Hosting;
using System.Web.Mvc;

namespace Assignment8.Controllers
{
    public class UsersController : Controller
    {
        public ActionResult Start()
        {
              return View("Login");
        }

        public ActionResult Login()
        {
            String login = Request["login"];
            String password = Request["password"];

            var obj = UserDAO.ValidateUser(login, password);
            if (obj != null)
            {
                Session["user"] = obj;
                Session["pid"] = 0;
                Session["prevPid"] = -1;
                return Redirect("~/Users/Home");
            }

            ViewBag.MSG = "Invalid Login/Password";
            return Redirect("~/Users/Start");
        }

        public ActionResult Home()
        {
            return View();
        }

        public ActionResult Folder()
        {
            return View();
        }

        public ActionResult NewFolder()
        {
            String folderName = Request["folderName"];
            FolderDTO f = new FolderDTO();
            f.folderName = folderName;
            f.createdOn = DateTime.Now.ToString("yyyy-MM-dd hh:mm:ss");
            f.parentFolderId = Convert.ToInt32(Session["pid"]);

            if (FolderDAO.Save(f) == 1)
            {
                return Redirect("~/Users/Home");
            }

            return Redirect("~/Users/Home");
        }


        public ActionResult openFolder(int pId)
        {

            //int  p  = FolderDAO.getParentFolderid(pId);
            //int p2= FolderDAO.getParentFolderid(p);
            Session["prevPid"] = pId;
            Session["pid"] = pId;
            Session["folderName"] = FolderDAO.getFoldernameByid(pId);
            return Redirect("~/Users/Folder");
        }

        public ActionResult openFolder2(int pId)
        {

            int  p  = FolderDAO.getParentFolderid(pId);
            Session["prevPid"] = p;
            Session["pid"] = p;
            Session["folderName"] = FolderDAO.getFoldernameByid(p);
            return Redirect("~/Users/Folder");
        }




        public JsonResult detailasjson(int pId)
        {
            return Json(FolderDAO.GetAllFolders(pId), JsonRequestBehavior.AllowGet);
        }

        public JsonResult detailasjson2(int pId)
        {
            return Json(FolderDAO.GetAllFolders2(pId), JsonRequestBehavior.AllowGet);
        }

        public ActionResult saveFile()
        {
            if (Request.Files["file"] != null)
            {
                var uniqueName = "";
                FileDTO f = new FileDTO();
                var file = Request.Files["file"];
                if (file.FileName != "")
                {
                    var ext = System.IO.Path.GetExtension(file.FileName);
                    f.fileExt = ext;
                    f.fileSizeInKb = file.ContentLength/1000;
                    f.uploadedOn = DateTime.Now.ToString("yyyy-MM-dd hh:mm:ss");
                    f.IsActive = true;
                    f.parentFolderId = Convert.ToInt32(Session["pid"]);                
                    uniqueName = Guid.NewGuid().ToString() + ext;
                    f.fileName = uniqueName;
                    var rootPath = Server.MapPath("~/UploadedFiles");
                    var fileSavePath = System.IO.Path.Combine(rootPath, uniqueName);
                    file.SaveAs(fileSavePath);
                   // Session["image"] = uniqueName;
                }
                FileDAO.Save(f);
            }

          

            return Redirect("~/Users/Folder");
        }


        public JsonResult getFiles(int pId)
        {
            return Json(FileDAO.GetAllFiles(pId), JsonRequestBehavior.AllowGet);
        }

        public ActionResult Download(string file)
        {
            file = HostingEnvironment.MapPath("~/UploadedFiles/" + file);

            string contentType = "application/octet-stream";
            var fileName = Path.GetFileName(file);
            return File(file, contentType, fileName);
        }

        public ActionResult deleteFolder(int fID)
        {

            FolderDAO.DeleteFolder(fID);


            return Redirect("~/Users/Folder");
        }

        public ActionResult deleteFile(string fn)
        {


            FileDAO.DeleteFile(fn);

            return Redirect("~/Users/Folder");
        }

        public ActionResult DownloadMeta()
        {

            int pId = Convert.ToInt32(Request["pid"]);
            
            
            List<FolderDTO> folders= new List<FolderDTO>();
            folders=FolderDAO.GetAllFolders(pId);

            List<FolderDTO> tempfolders = new List<FolderDTO>();
            foreach (var folder in folders)
            {
                tempfolders.AddRange(FolderDAO.GetAllFolders(folder.folderId));
                  
            }
            folders.AddRange(tempfolders);


            List<FileDTO> files;
            files = FileDAO.GetAllFiles(pId);
            List<FileDTO> tempfiles= new List<FileDTO>();
            foreach (var file in files)
            {
                tempfiles.AddRange(FileDAO.GetAllFiles(file.parentFolderId));
            }
            files.AddRange(tempfiles);




            PdfDocument pdf = new PdfDocument();
            pdf.Info.Title = "Meta Data";
            PdfPage pdfPage = pdf.AddPage();
            XGraphics graph = XGraphics.FromPdfPage(pdfPage);
            XFont font = new XFont("Times New Roman", 10, XFontStyle.Regular);
            int i = 0;
            int j = 0;
            
            foreach (var folder in folders)
            {
                string foldername = FolderDAO.getFoldernameByid(folder.parentFolderId);

                if(folder.parentFolderId==0)
                {
                    foldername = "Root";
                }
                graph.DrawString("Name: "+folder.folderName.ToString(), font, XBrushes.Black, new XRect(i,j,250,220), XStringFormats.TopLeft);
                graph.DrawString("Type: FOLDER", font, XBrushes.Black, new XRect(i,j+10, 250, 220), XStringFormats.TopLeft);
                graph.DrawString("Parent: " + foldername, font, XBrushes.Black, new XRect(i,j+20, 250, 220), XStringFormats.TopLeft);
                j = j + 40;
            }

            foreach (var file in files)
            {

                string foldername = FolderDAO.getFoldernameByid(file.parentFolderId);
                if (file.parentFolderId == 0)
                {
                    foldername = "Root";
                }
                graph.DrawString("Name: " +file.fileName, font, XBrushes.Black, new XRect(i, j, 250, 220), XStringFormats.TopLeft);
                graph.DrawString("Type: FILE", font, XBrushes.Black, new XRect(i, j + 10, 250, 220), XStringFormats.TopLeft);
                graph.DrawString("Size: " + file.fileSizeInKb+" KB", font, XBrushes.Black, new XRect(i, j + 20, 250, 220), XStringFormats.TopLeft);
                graph.DrawString("Parent: " + foldername, font, XBrushes.Black, new XRect(i, j + 30, 250, 220), XStringFormats.TopLeft);
                j = j + 50;
            }
            string pdfFilename = "MetaData.pdf";
            //pdf.Save(pdfFilename);

                //var file = pdf;
                var ext = ".pdf";               
                var uniqueName = "MetaData" + ext;              
                var rootPath = Server.MapPath("~/UploadedFiles");
                var fileSavePath = System.IO.Path.Combine(rootPath, uniqueName);
                pdf.Save(fileSavePath);
            // Session["image"] = uniqueName;
            return Download("MetaData.pdf");
           
        }

    }
}
