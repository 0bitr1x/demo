using Demo2026.Model;
using System.Linq;

namespace Demo2026
{
    public partial class Form1 : Form
    {
        public static Form1 Instance;
        public static User User { get; set; }
        public Form1()
        {
            InitializeComponent();
            Instance=this;
        }
        private void buttonLogin_Click(object sender, EventArgs e)
        {
            using (Demo11Context db=new Demo11Context()) 
            {
                User user = db.Users.FirstOrDefault(p => p.Login == textBoxLogin.Text)!;
                if (user != null)
                {
                    if (user.Password == textBoxPassword.Text)
                    {
                        User= user;
                        MainForm form = new MainForm();
                        form.Show();
                        this.Hide();
                    }
                    else MessageBox.Show("Неверный пароль!");
                }
                else MessageBox.Show("Пользователь не найден!");
            }
        }
    }
}

