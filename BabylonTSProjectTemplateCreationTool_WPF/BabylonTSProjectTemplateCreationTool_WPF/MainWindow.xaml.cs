using Microsoft.Win32;
using Ookii.Dialogs.Wpf;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;

namespace BabylonTSProjectTemplateCreationTool_WPF
{
    /// <summary>
    /// MainWindow.xaml 的交互逻辑
    /// </summary>
    public partial class MainWindow : Window
    {
        private TextBox mTexbox = null;
        private string mOldPath = null;
        private string mProjectName = "New project name";
        public MainWindow()
        {
            InitializeComponent();
        }

        private void Button_Click(object sender, RoutedEventArgs e)
        {
            if (mProjectName == "New project name" || mProjectName == null)
            {
                MessageBox.Show("Please enter project name");
                return;
            }
            if (mTexbox.Text == "Enter project path")
            {
                MessageBox.Show("Please enter project path!");
                return;
            }
            string writePath = mTexbox.Text + "\\" + mProjectName;
            if (!Directory.Exists(writePath))
            {
                DirectoryInfo directory = new DirectoryInfo(writePath);
                directory.Create();
            }
            string str_web = ReadFile("Resources\\webpack.config.js");
            WriteFile(writePath + "\\webpack.config.js", str_web);

            string str_tscon = ReadFile("Resources\\tsconfig.json");
            WriteFile(writePath + "\\tsconfig.json", str_tscon);

            string str_html = ReadFile("Resources\\index.html");
            WriteFile(writePath + "\\index.html", str_html);

            if (!Directory.Exists(writePath + "\\assets\\scripts"))
            {
                DirectoryInfo directory = new DirectoryInfo(writePath + "\\assets\\scripts");
                directory.Create();
            }
            string str_index = ReadFile("Resources\\assets\\scripts\\index.ts");
            WriteFile(writePath + "\\assets\\scripts\\index.ts", str_index);

            string str = ReadFile("Resources\\cmd.bat");
            WriteFile(writePath + "\\cmd.bat", str);

            System.Diagnostics.Process p = new System.Diagnostics.Process();
            p.StartInfo.FileName = writePath + "\\cmd.bat";
            p.StartInfo.UseShellExecute = false;
            p.StartInfo.RedirectStandardInput = false;
            p.StartInfo.RedirectStandardOutput = false;
            p.StartInfo.RedirectStandardError = false;
            p.StartInfo.CreateNoWindow = false;
            p.Start();
        }

        private string ReadFile(string path)
        {
            FileStream fs = new FileStream(path, FileMode.OpenOrCreate, FileAccess.Read);
            StreamReader m_streamReader = new StreamReader(fs);
            m_streamReader.BaseStream.Seek(0, SeekOrigin.Begin);
            string str = null;
            string strLine = m_streamReader.ReadLine();
            while (strLine != null)
            {
                str += strLine + "\n";
                strLine = m_streamReader.ReadLine();
            }
            m_streamReader.Close();
            return str;
        }
        private void WriteFile(string path, string str)
        {
            FileStream fs = new FileStream(path, FileMode.Create, FileAccess.Write);
            StreamWriter m_streamWriter = new StreamWriter(fs);
            m_streamWriter.Flush();
            m_streamWriter.BaseStream.Seek(0, SeekOrigin.Begin);
            m_streamWriter.Write(str);
            m_streamWriter.Flush();
            m_streamWriter.Close();
        }

        private void TextBox_TextChanged(object sender, TextChangedEventArgs e)
        {
            if (mTexbox == null)
            {
                mTexbox = sender as TextBox;
            }
        }

        private void Choosefile_Click(object sender, RoutedEventArgs e)
        {
            VistaFolderBrowserDialog dialog = new VistaFolderBrowserDialog();
            dialog.Description = "选择文件夹";
            if ((bool)dialog.ShowDialog(this))
            {
                mTexbox.Text = dialog.SelectedPath;
                mOldPath = dialog.SelectedPath;
            }
        }

        private void TextBox_Copy_TextChanged(object sender, TextChangedEventArgs e)
        {
            TextBox text = sender as TextBox;
            mProjectName = text.Text;
        }
    }
}
