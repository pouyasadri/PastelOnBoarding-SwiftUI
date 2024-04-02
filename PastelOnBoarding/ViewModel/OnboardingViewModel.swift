//
//  OnboardingViewModel.swift
//  PastelOnBoarding
//
//  Created by Pouya Sadri on 01/04/2024.
//

import SwiftUI

class OnboardingViewModel : ObservableObject{
	// Published properties to hold onboarding data
	@Published var onboardingPages : [OnboardingPage] = [
		OnboardingPage(imageName: "onboarding1",
					   title: "Welcome to our Delivery \nService!",
					   description: "Get your favorite items delivered right to your doorstep hassle-free."), // First onboarding page data
		OnboardingPage(imageName: "onboarding2",
					   title: "Track Your Delivery in \nReal-Time",
					   description: "Stay updated with the whereabouts of your package as it makes its way to you."), // Second onboarding page data
		OnboardingPage(imageName: "onboarding3",
					   title: "Enjoy Fast and Reliable \nDelivery",
					   description: "Experience quick and dependable delivery services that ensure your orders arrive promptly and in perfect condition."), // Third onboarding page data
	]
	
	//Define colors for each onboarding page
	@Published var pageColors : [Color] = [.background.opacity(0.33), .background.opacity(0.66), .background]
	
	//Defined property to manage onboarding state
	@Published var currentPageIndex : Int = 0
	
	//function to navigate to the next onboarding page
	func goToNextPage(){
		if currentPageIndex < onboardingPages.count - 1{
			withAnimation{
				currentPageIndex += 1
			}
		}
	}
	
	// function to navigate to the previous onboarding page
	func goToPreviousPage(){
		if currentPageIndex > 0 {
			withAnimation{
				currentPageIndex -= 1
			}
		}
	}
	
	//function to skip onboarding and proceed to the last page
	func skipOnboarding(){
		withAnimation{
			currentPageIndex = onboardingPages.count - 1
		}
	}
}
