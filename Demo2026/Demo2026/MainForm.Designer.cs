namespace Demo2026
{
    partial class MainForm
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
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
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            labelUser = new Label();
            panel1 = new Panel();
            button1 = new Button();
            comboBox1 = new ComboBox();
            label1 = new Label();
            label2 = new Label();
            textBox1 = new TextBox();
            SuspendLayout();
            // 
            // labelUser
            // 
            labelUser.Font = new Font("Segoe UI", 14F);
            labelUser.Location = new Point(580, 9);
            labelUser.Name = "labelUser";
            labelUser.Size = new Size(208, 45);
            labelUser.TabIndex = 0;
            labelUser.Text = "label1";
            labelUser.TextAlign = ContentAlignment.MiddleCenter;
            // 
            // panel1
            // 
            panel1.AutoScroll = true;
            panel1.Dock = DockStyle.Left;
            panel1.Location = new Point(0, 0);
            panel1.Name = "panel1";
            panel1.Size = new Size(566, 450);
            panel1.TabIndex = 1;
            // 
            // button1
            // 
            button1.Location = new Point(580, 370);
            button1.Name = "button1";
            button1.Size = new Size(208, 23);
            button1.TabIndex = 2;
            button1.Text = "Добавить";
            button1.UseVisualStyleBackColor = true;
            button1.Click += button1_Click;
            // 
            // comboBox1
            // 
            comboBox1.FormattingEnabled = true;
            comboBox1.Items.AddRange(new object[] { "Наименование", "Приоритет" });
            comboBox1.Location = new Point(580, 90);
            comboBox1.Name = "comboBox1";
            comboBox1.Size = new Size(196, 23);
            comboBox1.TabIndex = 3;
            comboBox1.SelectedIndexChanged += comboBox1_SelectedIndexChanged;
            // 
            // label1
            // 
            label1.AutoSize = true;
            label1.Location = new Point(580, 63);
            label1.Name = "label1";
            label1.Size = new Size(73, 15);
            label1.TabIndex = 4;
            label1.Text = "Сортировка";
            // 
            // label2
            // 
            label2.AutoSize = true;
            label2.Location = new Point(580, 126);
            label2.Name = "label2";
            label2.Size = new Size(154, 15);
            label2.TabIndex = 5;
            label2.Text = "Введите строку для поиска";
            // 
            // textBox1
            // 
            textBox1.Location = new Point(580, 153);
            textBox1.Name = "textBox1";
            textBox1.Size = new Size(187, 23);
            textBox1.TabIndex = 6;
            textBox1.TextChanged += textBox1_TextChanged;
            // 
            // MainForm
            // 
            AutoScaleDimensions = new SizeF(7F, 15F);
            AutoScaleMode = AutoScaleMode.Font;
            ClientSize = new Size(800, 450);
            Controls.Add(textBox1);
            Controls.Add(label2);
            Controls.Add(label1);
            Controls.Add(comboBox1);
            Controls.Add(button1);
            Controls.Add(panel1);
            Controls.Add(labelUser);
            Name = "MainForm";
            Text = "Главная";
            FormClosed += MainForm_FormClosed;
            ResumeLayout(false);
            PerformLayout();
        }

        #endregion

        private Label labelUser;
        private Panel panel1;
        private Button button1;
        private ComboBox comboBox1;
        private Label label1;
        private Label label2;
        private TextBox textBox1;
    }
}