namespace Demo2026
{
    partial class Form1
    {
        /// <summary>
        ///  Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        ///  Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        ///  Required method for Designer support - do not modify
        ///  the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            textBoxLogin = new TextBox();
            textBoxPassword = new TextBox();
            buttonLogin = new Button();
            SuspendLayout();
            // 
            // textBoxLogin
            // 
            textBoxLogin.Font = new Font("Segoe UI", 14F);
            textBoxLogin.Location = new Point(36, 30);
            textBoxLogin.Name = "textBoxLogin";
            textBoxLogin.PlaceholderText = "Введите логин";
            textBoxLogin.Size = new Size(192, 32);
            textBoxLogin.TabIndex = 0;
            // 
            // textBoxPassword
            // 
            textBoxPassword.Font = new Font("Segoe UI", 14F);
            textBoxPassword.Location = new Point(36, 84);
            textBoxPassword.Name = "textBoxPassword";
            textBoxPassword.PasswordChar = '*';
            textBoxPassword.PlaceholderText = "Введите пароль";
            textBoxPassword.Size = new Size(192, 32);
            textBoxPassword.TabIndex = 1;
            // 
            // buttonLogin
            // 
            buttonLogin.BackColor = Color.LightGreen;
            buttonLogin.Font = new Font("Segoe UI", 14F);
            buttonLogin.Location = new Point(83, 147);
            buttonLogin.Name = "buttonLogin";
            buttonLogin.Size = new Size(98, 39);
            buttonLogin.TabIndex = 2;
            buttonLogin.Text = "Вход";
            buttonLogin.UseVisualStyleBackColor = false;
            buttonLogin.Click += buttonLogin_Click;
            // 
            // Form1
            // 
            AutoScaleDimensions = new SizeF(7F, 15F);
            AutoScaleMode = AutoScaleMode.Font;
            ClientSize = new Size(284, 211);
            Controls.Add(buttonLogin);
            Controls.Add(textBoxPassword);
            Controls.Add(textBoxLogin);
            Name = "Form1";
            SizeGripStyle = SizeGripStyle.Show;
            Text = "Авторизация";
            ResumeLayout(false);
            PerformLayout();
        }

        #endregion

        private TextBox textBoxLogin;
        private TextBox textBoxPassword;
        private Button buttonLogin;
    }
}
