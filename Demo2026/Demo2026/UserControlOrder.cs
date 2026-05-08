using Demo2026.Model;
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
    public partial class UserControlOrder : UserControl
    {
        private Agent agent;
        private MainForm mainForm;
        public UserControlOrder(Agent _agent, MainForm _form)
        {
            InitializeComponent();
            this.agent = _agent;
            this.mainForm = _form;
            try
            {
                label1.Text = "Скидка: 0%"; // Здесь должна быть логика расчета скидки от продаж
                label2.Text = agent.AgentType?.Title + " | " + agent.Title;
                label3.Text = "Директор: " + agent.DirectorName;
                label4.Text = "Телефон: " + agent.Phone;
                label5.Text = "Email: " + agent.Email;
                label6.Text = "Приоритет: " + agent.Priority;
                label7.Text = "Адрес: " + agent.Address;
                label8.Visible = false;
                label9.Visible = false;

                if (!string.IsNullOrEmpty(agent.Logo))
                {
                    string path = Environment.CurrentDirectory + agent.Logo;
                    if (File.Exists(path))
                        pictureBox1.Image = Image.FromFile(path);
                    else
                        pictureBox1.Image = Properties.Resources.picture;
                }
                else
                {
                    pictureBox1.Image = Properties.Resources.picture;
                }
            }
            catch (Exception ex)
            {
                // MessageBox.Show(ex.Message);
            }
        }

        private void удалитьToolStripMenuItem_Click(object sender, EventArgs e)
        {
            DialogResult result = MessageBox.Show($"Вы хотите удалить элемент {agent.Title}", "Удаление", MessageBoxButtons.YesNo, MessageBoxIcon.Warning);
            if (result == DialogResult.Yes)
            {
                using (Demo11Context db = new Demo11Context())
                {
                    db.Agents.Remove(agent);
                    db.SaveChanges();
                    mainForm.UpdateForm(db.Agents.ToList());
                }
            }
        }

        private void UserControlOrder_DoubleClick(object sender, EventArgs e)
        {
            FormOrder form = new FormOrder(agent);
            if (form.ShowDialog() == DialogResult.OK)
            {
                // Обновление данных агента
                agent.Title = form.textBoxName.Text;
                agent.Phone = form.textBoxPhone.Text;
                agent.Priority = int.Parse(form.textBoxPriority.Text);
                agent.DirectorName = form.textBoxDirector.Text;
                agent.Email = form.textBoxEmail.Text;
                agent.Address = form.textBoxAddress.Text;
                agent.AgentTypeId = (int)form.comboBoxType.SelectedValue;

                if (form.FilePath != null)
                {
                    FileInfo file = new FileInfo(form.FilePath);
                    if (!Directory.Exists(Environment.CurrentDirectory + @"\agents\"))
                        Directory.CreateDirectory(Environment.CurrentDirectory + @"\agents\");
                    file.CopyTo(Environment.CurrentDirectory +
                        @"\agents\" + form.FileName, true);
                    agent.Logo = @"\agents\" + form.FileName;
                }
                using (Demo11Context db = new Demo11Context())
                {
                    db.Agents.Update(agent);
                    db.SaveChanges();
                    mainForm.UpdateForm(db.Agents.ToList());
                }
            }
        }
    }
}
