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
    public partial class FormOrder : Form
    {
        public string FilePath;
        public string FileName;
        public FormOrder(Agent agent)
        {
            InitializeComponent();
            using (Demo11Context db = new Demo11Context())
            {
                comboBoxType.DataSource = db.AgentTypes.ToList();
                comboBoxType.DisplayMember = "Title";
                comboBoxType.ValueMember = "Id";
            }

            textBoxName.Text = agent.Title;
            textBoxPhone.Text = agent.Phone;
            textBoxPriority.Text = agent.Priority.ToString();
            textBoxDirector.Text = agent.DirectorName;
            textBoxEmail.Text = agent.Email;
            textBoxAddress.Text = agent.Address;
            textBoxInn.Text = agent.Inn;
            textBoxKpp.Text = agent.Kpp;
            
            if (agent.AgentTypeId != 0)
            {
                comboBoxType.SelectedValue = agent.AgentTypeId;
            }

            if (!string.IsNullOrEmpty(agent.Logo))
            {
                string path = Environment.CurrentDirectory + agent.Logo;
                if (File.Exists(path))
                    pictureBox1.Image = Image.FromFile(path);
            }
        }

        private void button1_Click(object sender, EventArgs e)
        {
            if (openFileDialog1.ShowDialog() == DialogResult.OK)
            {
                pictureBox1.Image = Image.FromFile(openFileDialog1.FileName);
                FilePath = openFileDialog1.FileName;
                FileName = openFileDialog1.SafeFileName;
            }
        }
    }
}
