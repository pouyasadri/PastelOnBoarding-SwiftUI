//
//  ContentView.swift
//  PastelOnBoarding
//
//  Created by Pouya Sadri on 01/04/2024.
//

import SwiftUI

struct ContentView: View {
	@StateObject var viewModel = OnboardingViewModel()// viewModel to manage onboarding data
	
	var body: some View {
		ZStack{
			Color.black.ignoresSafeArea()
			
			GeometryReader{proxy in
				Path{
					path in
					
					path.move(to: CGPoint(x: 0, y: 0))
					path.addLine(to: CGPoint(x: proxy.size.width * 0.65, y: 0))
					path.addLine(to: CGPoint(x: proxy.size.width * 0.35, y: proxy.size.height))
					path.addLine(to: CGPoint(x: 0, y: proxy.size.height))
					path.closeSubpath()
				}
				.fill(viewModel.pageColors[viewModel.currentPageIndex])
				
			}
			.ignoresSafeArea()
			
			RectangleView() //A white Rectangle view
			
			VStack{
				SKipButton(action: viewModel.skipOnboarding)
				
				OnboardingPagesView(viewModel: viewModel)
				
				HStack{
					CustomPageIndicator(pageCount: viewModel.onboardingPages.count, currentPageIndex: viewModel.currentPageIndex)
					
					Spacer()
					
					if viewModel.currentPageIndex > 0 {
						PreviousPageButton(action: viewModel.goToPreviousPage)
					}
					
					NextPageButton(action: viewModel.goToNextPage)
				}
				.padding(EdgeInsets(top: 40, leading: 50, bottom: 30, trailing: 50))
			}
		}
    }
}

//MARK: - RectangleView is a custom view for the white rectangle
struct RectangleView : View {
	var body: some View {
		Rectangle()
			.cornerRadius(radius: 100, corners: [.topRight])
			.cornerRadius(3)
			.frame(maxHeight: 350)
			.foregroundStyle(.white)
			.padding(.horizontal,20)
			.frame(maxHeight: .infinity,alignment: .bottom)
	}
}

//MARK: - SkipButton is a button to skip onboarding
struct SKipButton : View {
	var action : ()-> Void
	var body: some View {
		Button(action:action){
			Rectangle()
				.frame(width: 60,height: 25)
				.foregroundStyle(.white)
				.cornerRadius(radius: 15, corners: [.topRight])
				.cornerRadius(3)
				.overlay{
					Text("SKIP")
						.foregroundStyle(Color.textColor)
						.font(.system(size: 12))
						.kerning(0.6)
				}
		}
		.frame(maxWidth: .infinity,alignment: .trailing)
		.padding(.horizontal,30)
		.buttonStyle(.plain)
	}
}

//MARK: - OnboardingPagesView is used to display a collection of onboarding pages
struct OnboardingPagesView : View {
	@ObservedObject var viewModel : OnboardingViewModel
	var body: some View {
		TabView(selection: $viewModel.currentPageIndex){
			ForEach(viewModel.onboardingPages.indices, id:\.self){
				index in
				OnboardingPageView(page: viewModel.onboardingPages[index])
			}
		}
		.tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
	}
}

//MARK: - OnboardingPageView is used to display individual onboarding pages
struct OnboardingPageView: View {
	let page : OnboardingPage
	var body: some View {
		VStack(alignment:.leading,spacing: 8){
			Image(page.imageName)
				.resizable()
				.scaledToFit()
				.frame(maxWidth: .infinity,maxHeight: 450,alignment: .trailing)
			
			Text(page.title)
				.font(.system(size: 22).weight(.semibold))
				.kerning(0.44)
				.lineSpacing(2.5)
			
			Rectangle()
				.foregroundStyle(.clear)
				.frame(width: 50,height: 3)
				.background(
					Color(red: 0.59, green: 0.72, blue: 0.68)
				)
				.cornerRadius(2)
			
			Text(page.description)
				.font(.system(size: 14))
				.kerning(0.28)
				.foregroundStyle(Color.textColor)
				.lineSpacing(5)
		}
		.padding(.horizontal,50)
	}
}

//MARK: - CustomPageIndicator display page indicators
struct CustomPageIndicator : View {
	let pageCount : Int // total number of onboarding pages
	let currentPageIndex : Int // current selected page index
	
	var body: some View {
		HStack(spacing: 8){
			ForEach(0 ..< pageCount, id: \.self){
				index in
				if currentPageIndex == index {
					Circle()
						.fill(.clear)
						.frame(width: 15,height: 15)
						.commonLinearGradient(colors: [.greenishGray,.oliveGreen])
						.clipShape(Circle())
						.shadow(color: .shadowColor, radius: 7.5, y: 5)
				}else{
					Circle()
						.fill(Color(red: 0.85, green: 0.85, blue: 0.85))
						.frame(width: 15,height: 15)
				}
			}
		}
	}
}

//MARK: - PreviousPageButton is a button to navigate to the previous Page
struct PreviousPageButton : View {
	var action : () -> Void
	var body: some View {
		Button(action: action){
			Image("back")
				.resizable()
				.scaledToFit()
				.frame(width: 50,height: 50)
		}
	}
}

//MARK: - NextPageButton is a button to navigate to the next page
struct NextPageButton : View {
	var action : () -> Void
	var body: some View {
		Button(action: action){
			Rectangle()
				.fill(.clear)
				.frame(width: 50,height: 50)
				.commonLinearGradient(colors: [.greenishGray,.oliveGreen])
				.cornerRadius(10)
				.cornerRadius(radius: 25, corners: [.topRight])
				.shadow(color: .shadowColor, radius: 7.5,y:5)
				.overlay{
					Image("Right")
						.resizable()
						.scaledToFit()
						.frame(width: 18,height: 18)
				}
		}
	}
}

//MARK: - CornerRadiusShape and CornerRadiusStyle are reused from your code
struct CornerRadiusShape : Shape{
	var radius = CGFloat.infinity
	var corners = UIRectCorner.allCorners
	
	func path(in rect: CGRect) -> Path {
		let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
		
		return Path(path.cgPath)
	}
}

struct CornerRadiusStyle : ViewModifier{
	var radius : CGFloat
	var corners : UIRectCorner
	
	func body(content: Content) -> some View {
		content
			.clipShape(CornerRadiusShape(radius: radius,corners: corners))
	}
}

#Preview {
    ContentView()
}
