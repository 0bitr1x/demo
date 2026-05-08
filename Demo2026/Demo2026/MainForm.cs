using Demo2026.Model;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Demo2026
{
    public partial class MainForm : Form
    {
        private List<Agent> list;
        private Demo11Context db;
        public MainForm()
        {
            InitializeComponent();
            labelUser.Text = Form1.User.LastName + " " + (Form1.User.FirstName?.Substring(0, 1) ?? "") + "."
               + (Form1.User.MiddleName?.Substring(0, 1) ?? "") + ".";
            db = new Demo11Context();
            list = db.Agents.Include(p => p.AgentType).ToList();
            UpdateForm(list);
            if(Form1.User.Role=="Агент")
            {
                textBox1.Visible=false;
                label2.Visible=false;
                label1.Visible=false;
                comboBox1.Visible=false;
                button1.Visible=false;
            }
        }
        private void MainForm_FormClosed(object sender, FormClosedEventArgs e)
        {
            Form1.Instance.Show();
        }
        public void UpdateForm(List<Agent> list)
        {
            //обновление формы
            panel1.Controls.Clear();
            int y = 0;
            foreach (Agent agent in list)
            {
                UserControlOrder uc = new UserControlOrder(agent, this);
                uc.Top = y;
                panel1.Controls.Add(uc);
                y += uc.Height;
            }
        }

        private void button1_Click(object sender, EventArgs e)
        {
            //добавление элемента
            FormOrder formAdd = new FormOrder(new Agent());
            if (formAdd.ShowDialog() == DialogResult.OK)
            {
                Agent agent = new Agent();
                agent.Title = formAdd.textBoxName.Text;
                agent.AgentTypeId = (int)formAdd.comboBoxType.SelectedValue;
                agent.Phone = formAdd.textBoxPhone.Text;
                agent.Priority = int.Parse(formAdd.textBoxPriority.Text);
                agent.Address = formAdd.textBoxAddress.Text;
                agent.Inn = formAdd.textBoxInn.Text;
                agent.Kpp = formAdd.textBoxKpp.Text;
                agent.DirectorName = formAdd.textBoxDirector.Text;
                agent.Email = formAdd.textBoxEmail.Text;
                
                if (formAdd.FilePath != null)
                {
                    FileInfo file= new FileInfo(formAdd.FilePath);
                    if (!Directory.Exists(Environment.CurrentDirectory + @"\agents\"))
                        Directory.CreateDirectory(Environment.CurrentDirectory + @"\agents\");
                    file.CopyTo(Environment.CurrentDirectory +
                        @"\agents\" + formAdd.FileName, true);
                    agent.Logo = @"\agents\" + formAdd.FileName;
                }
                db.Agents.Add(agent);
                db.SaveChanges();
                UpdateForm(db.Agents.Include(p => p.AgentType).ToList());
            }

        }

        private void comboBox1_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (comboBox1.SelectedIndex != -1)
            {
                switch (comboBox1.SelectedIndex)
                {
                    case 0:
                        list = db.Agents.Include(p => p.AgentType).OrderBy(p => p.Title).ToList();
                        break;
                    case 1:
                        list = db.Agents.Include(p => p.AgentType).OrderByDescending(p => p.Priority).ToList();
                        break;
                }
                UpdateForm(list);
            }
        }

        private void textBox1_TextChanged(object sender, EventArgs e)
        {
            if (textBox1.Text.Length > 0)
            {
                list = db.Agents.Include(p => p.AgentType).Where(p => p.Title.Contains(textBox1.Text) ||
                                        p.Phone.Contains(textBox1.Text) ||
                                        p.Email.Contains(textBox1.Text)).ToList();
                UpdateForm(list);
            }
            else
            {
                list = db.Agents.Include(p => p.AgentType).ToList();
                UpdateForm(list);
            }
        }
    }
}
